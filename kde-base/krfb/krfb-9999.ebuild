# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
inherit kde-meta eutils
DESCRIPTION="[GIT] VNC-compatible server to share KDE desktops"
IUSE="kdehiddenvisibility slp"

DEPEND="slp? ( net-libs/openslp )
	x11-libs/libXtst"

src_compile() {
	myconf="$myconf $(use_enable slp)"
	kde-meta_src_compile
}
