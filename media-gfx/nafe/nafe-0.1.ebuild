# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="toolset to translate psf format consolefonts into text files and text files into psf files"
HOMEPAGE="https://nafe.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PN}-${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	echo "configured";
}

src_compile() {
	emake
}

src_install() {
	exeinto /usr/local/bin
	doexe txt2psf
	doexe psf2txt
}
