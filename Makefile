# Copyright (C) 2022 Centre National de la Recherche Scientifique
# Copyright (C) 2022 Institut Mines Télécom Albi-Carmaux
# Copyright (C) 2022 |Méso|Star> (contact@meso-star.com)
# Copyright (C) 2022 Université Clermont Auvergne
# Copyright (C) 2022 Université de Lorraine
# Copyright (C) 2022 Université de Lyon
# Copyright (C) 2022 Université de Toulouse
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

.POSIX:
.SUFFIXES:
SHELL := /bin/bash

PREFIX=/usr/local/

SCRIPTS=\
selectDate\

DESKTOPS=\
selectDate.desktop\

ICONS=\
selectDate.svg\

# --- DEPENDANCES A VERIFIER ---
DEPS = xclip wl-copy zenity

# Mapping Paquet/Description pour l'affichage des messages
# Format : Exécutable:Paquet_ou_nom_courant:Description
# Nous utilisons ici uniquement des caracteres ASCII
DEP_INFO = \
xclip:xclip:Presse-papiers X11 \
wl-copy:wl-clipboard:Presse-papiers Wayland \
zenity:zenity:Boites de dialogue GUI

# --- CIBLE DE VERIFICATION AMELIOREE SANS ACCENTS ---
.PHONY: check_deps
check_deps:
	@echo "--- Demarrage de la verification des dependances ---"
	@EXIT_CODE=0; \
	for dep in $(DEPS); do \
		case "$$dep" in \
			"xclip") \
				EXE="xclip"; PACKAGE="xclip"; DESC="Presse-papiers X11"; \
				;; \
			"wl-copy") \
				EXE="wl-copy"; PACKAGE="wl-clipboard"; DESC="Presse-papiers Wayland"; \
				;; \
			"zenity") \
				EXE="zenity"; PACKAGE="zenity"; DESC="Boites de dialogue GUI"; \
				;; \
			*) \
				EXE="$$dep"; PACKAGE="INCONNU"; DESC="Outil Inconnu"; \
				;; \
		esac; \
		\
		if ! command -v $$EXE &> /dev/null; then \
			echo "[ECHEC] L'outil '$$EXE' (Paquet: $$PACKAGE) est introuvable."; \
			echo "        - Role : $$DESC"; \
			echo "        - Action: Veuillez installer le paquet '$$PACKAGE' via votre gestionnaire de paquets (apt, dnf, pacman, etc.)."; \
			EXIT_CODE=1; \
		else \
			echo "[OK] Outil '$$EXE' ($$DESC) trouve."; \
		fi; \
	done; \
	\
	if [ $$EXIT_CODE -ne 0 ]; then \
		echo "--- VERIFICATION TERMINEE AVEC ECHEC. L'installation est annulee. ---"; \
		exit 1; \
	else \
		echo "--- VERIFICATION TERMINEE AVEC SUCCES. Toutes les dependances sont pretes. ---"; \
	fi

install: check_deps
	@echo "Installation des fichiers..."
	cp $(SCRIPTS) $(PREFIX)/bin/
	cp $(DESKTOPS) $(PREFIX)/share/applications
	cp $(ICONS) $(PREFIX)share/icons
	chmod +x $(PREFIX)/bin/$(SCRIPTS)
	@echo "Installation terminee avec succes."


uninstall:
	@echo "Desinstallation des fichiers..."
	@for f in $(SCRIPTS); do rm -f "$(PREFIX)/bin/$${f}"; done
	@for f in $(DESKTOPS); do rm -f "$(PREFIX)/share/applications/$${f}"; done
	@for f in $(ICONS); do rm -f "$(PREFIX)/share/icons/$${f}"; done
	@echo "Desinstallation terminee."

lint:
	@shellcheck -o all $(SCRIPTS)
