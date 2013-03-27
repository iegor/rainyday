# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
ARTS_REQUIRED="never"
inherit kde-meta
DESCRIPTION="[GIT] A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=2108"

need-kde ${PV}

LICENSE="GPL-2"
SLOT="3.5"
IUSE=""

DEPEND="=kde-base/kwin-${PV}:${SLOT}"
