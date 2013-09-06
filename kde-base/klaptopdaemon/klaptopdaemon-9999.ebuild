# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] KLaptopdaemon - KDE battery monitoring and management for laptops."
IUSE="kdehiddenvisibility xscreensaver"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="x11-libs/libXtst
	xscreensaver? ( x11-libs/libXScrnSaver )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"
	kde_src_compile
}
