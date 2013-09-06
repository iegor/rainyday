# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMMODULE=kscreensaver
KMNAME=kdeartwork
inherit kde-meta
DESCRIPTION="[GIT] Extra screensavers for kde"
IUSE="opengl xscreensaver"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/kscreensaver-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_compile() {
	local myconf="$myconf --with-dpms --with-libart
				$(use_with opengl gl) $(use_with xscreensaver)"

	kde-meta_src_compile
}
