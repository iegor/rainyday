# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
KMEXTRA="kfile-plugins/pdf"
inherit kde-meta flag-o-matic
DESCRIPTION="[GIT] kpdf, a kde pdf viewer based on xpdf"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=">=media-libs/freetype-2.3
	media-libs/t1lib
	>=app-text/poppler-0.12.3-r3[qt3]"
RDEPEND="${DEPEND}
	|| ( >=kde-base/kdeprint-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"

PATCHES=( "${FILESDIR}/kde-CVE-2009-1188.patch"
	"${FILESDIR}/${KMNAME}_${PN}-r983313.patch"
	"${FILESDIR}/${P}-font-hiding.patch"
	"${FILESDIR}/kpdf-3.5.10-xpdf-3.02pl4.patch" )

src_compile() {
	local myconf="--with-poppler"
	replace-flags "-Os" "-O2" # see bug 114822

	# Fix the desktop file.
	sed -i -e "s:PDFViewer;:Viewer;:" "${S}/kpdf/shell/kpdf.desktop"

	kde-meta_src_compile
}
