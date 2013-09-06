# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="HLLib is a package library for Half-Life that abstracts several package formats and provides a simple interface for all of them."
HOMEPAGE="http://nemesis.thewavelength.net/index.php?p=35"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Rupan/HLLib.git"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}
	epatch ${FILESDIR}/hhlib-2.4.0-gentoo-install.diff
}

src_compile() {
	emake -C HLLib -f Makefile
}

src_install() {
	emake -C HLLib -f Makefile DESTDIR=${D} install # -C HLLib -f Makefile install
	pushd `pwd`
	cd HLExtract/
	gcc -O2 -g -I${D}/usr/local/include -L${D}/usr/local/lib/ Main.c -o ./hlextract -lhl
	popd
	#ldconfig
	exeinto /usr/local/bin
	doexe HLExtract/hlextract
}
