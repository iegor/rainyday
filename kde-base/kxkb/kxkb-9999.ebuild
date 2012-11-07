# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxkb/kxkb-3.5.10.ebuild,v 1.8 2009/07/12 11:13:16 armin76 Exp $
EAPI="1"
KMNAME=kdebase

inherit kde-meta eutils

DESCRIPTION="[GIT] KControl module for the X11 keyboard extension to configure and switch between keyboard mappings."
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KDE_DOWNLOAD_SOURCE="git"

DEPEND="x11-libs/libXtst"
RDEPEND="x11-libs/libXtst
	x11-misc/xkeyboard-config
	x11-apps/setxkbmap"

KMEXTRACTONLY="${KMEXTRACTONLY}
	kdm/configure.in.in"

PATCHES="${FILESDIR}/kdm-3.5-noimake.patch"

src_unpack() {
	kde-meta_src_unpack

	# Remove reference to kde.desktop in AC_OUTPUT to allow building with
	# autoconf 2.59d
	sed -i -e '/kde.desktop/ s:^:#:g' "${S}/kdm/configure.in.in"
}
