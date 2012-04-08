# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

RESTRICT="nomirror"
DESCRIPTION="second Clearlook-like KDE style. It is based on QtCurve"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=31717"
SRC_URI="http://www.kde-look.org/content/files/31717-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.2 )
	$(qt_min_version 3.3)"
	need-kde 3.2

	src_unpack() {
	kde_src_unpack
	}
