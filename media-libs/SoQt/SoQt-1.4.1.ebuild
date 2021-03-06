# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.4.1.ebuild,v 1.6 2009/10/29 11:02:54 fauli Exp $

EAPI=2

inherit flag-o-matic eutils

DESCRIPTION="The glue between Coin3D and Qt"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/all/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 x86"
IUSE="doc qt4 qt3"

RDEPEND=">=media-libs/coin-2.4.4
	qt4? (
		dev-qt/qt-gui:4[qt3support]
		dev-qt/qt-opengl:4[qt3support]
		dev-qt/qt-qt3support:4
	)
	qt3? ( dev-qt/qt-meta:3[opengl] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc44.patch"
}

src_configure() {
	if use qt4; then
		export PATH="/usr/bin/:${PATH}"
		export QTDIR="/usr"
		export CONFIG_QTLIBS="$(pkg-config --libs QtGui)"
	fi

	append-ldflags $(no-as-needed)

	econf --with-coin --disable-html-help $(use_enable doc html) htmldir=/usr/share/doc/${PF}/html
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README*
}
