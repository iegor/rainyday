# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE remote desktop connection (RDP and VNC) client"
IUSE="kdehiddenvisibility rdesktop slp"

DEPEND=">=dev-libs/openssl-0.9.6b
	slp? ( net-libs/openslp )
	x11-libs/libXxf86vm
	x11-libs/libXtst"
RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )"

src_compile() {
	local myconf="$(use_enable slp)"
	kde-meta_src_compile
}
