# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
inherit kde-meta eutils flag-o-matic
DESCRIPTION="[GIT] SVG viewer library and embeddable kpart"
IUSE=""

DEPEND=">=media-libs/freetype-2.3
	media-libs/fontconfig
	media-libs/libart_lgpl
	>=media-libs/lcms-2.0
	>=dev-libs/fribidi-0.19.5"
RDEPEND="${DEPEND}"

src_unpack() {
	kde-meta_src_unpack
	append-ldflags $(no-as-needed)
}
