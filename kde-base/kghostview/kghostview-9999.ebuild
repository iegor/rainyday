# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
KMEXTRA="kfile-plugins/ps"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
IUSE="X"

# Should also rdepend on kdeprint. Since kdeprint rdepends on kghostview for previews, we'd had a conflict, so we can't.
RDEPEND="app-text/ghostscript-gpl[X]"
