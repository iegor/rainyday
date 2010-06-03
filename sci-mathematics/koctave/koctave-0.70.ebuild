# Copyright 1999-2009 Gentoo Foundation                                                     
# Distributed under the terms of the GNU General Public License v2                          
# $Header: $                                                                                

EAPI="1"

inherit kde

DESCRIPTION="A KDE GUI for Octave numerical computing system"
HOMEPAGE="http://koctave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/koctave-docs-20050605.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="arts"

DEPEND="sci-mathematics/octave
	|| ( kde-base/konsole:3.5 kde-base/kdebase:3.5 )"

need-kde 3.5

src_unpack() {
	kde_src_unpack
#	epatch "${FILESDIR}"/${P}-desktop-entry-fix.patch
}

src_install() {
	kde_src_install
	dohtml "${WORKDIR}"/docs/*
}
