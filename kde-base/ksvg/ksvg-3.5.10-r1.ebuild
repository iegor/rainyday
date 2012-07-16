# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.5.10.ebuild,v 1.10 2009/10/04 15:08:29 ssuominen Exp $
EAPI="1"
KMNAME=kdegraphics
inherit kde-meta eutils flag-o-matic

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/freetype-2.3
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/25_ksvg_493363_handle_odd_coordinates.diff"
	"${FILESDIR}/fix-CVE-2009-0945.diff"
	"${FILESDIR}/fix-CVE-2009-1709.diff" )

src_unpack() {
	kde-meta_src_unpack

	if has_version ">=dev-libs/fribidi-0.19.1"; then
		epatch "${FILESDIR}/${PN}-fribidi.patch"
		append-ldflags $(no-as-needed)
	fi
}
