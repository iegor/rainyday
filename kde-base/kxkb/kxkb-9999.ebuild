# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMEXTRACTONLY="${KMEXTRACTONLY}
	kdm/configure.in.in"
inherit kde-meta eutils
DESCRIPTION="[GIT] KControl module for the X11 keyboard extension to configure and switch between keyboard mappings."
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="x11-libs/libXtst"
RDEPEND="x11-libs/libXtst
	x11-misc/xkeyboard-config
	x11-apps/setxkbmap"

src_unpack() {
	kde-meta_src_unpack

	# Remove reference to kde.desktop in AC_OUTPUT to allow building with
	# autoconf 2.59d
	sed -i -e '/kde.desktop/ s:^:#:g' "${S}/kdm/configure.in.in"
}
