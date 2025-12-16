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
install:
	cp $(SCRIPTS) $(PREFIX)/bin/
	cp $(DESKTOPS) $(PREFIX)/share/applications
	cp $(ICONS) $(PREFIX)share/icons
	chmod +x $(PREFIX)/bin/$(SCRIPTS)


uninstall:
	@for f in $(SCRIPTS); do rm -f "$(PREFIX)/bin/$${f}"; done
	@for f in $(DESKTOPS); do rm -f "$(PREFIX)/share/applications/$${f}"; done
	@for f in $(ICONS); do rm -f "$(PREFIX)/share/icons/$${f}"; done

lint:
	@shellcheck -o all $(SCRIPTS)
