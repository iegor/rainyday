# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE screensaver framework"
IUSE="kdehiddenvisibility opengl"

DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

src_compile() {
	myconf="$myconf $(use_with opengl gl)"
	kde-meta_src_compile
}
