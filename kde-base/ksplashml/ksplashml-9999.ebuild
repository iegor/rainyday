# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
IUSE="kdehiddenvisibility xinerama"

DEPEND="x11-libs/libXcursor
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="x11-libs/libXcursor
	xinerama? ( x11-libs/libXinerama )"

src_compile() {
	myconf="${myconf} $(use_with xinerama)"
	kde-meta_src_compile
}
