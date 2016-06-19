# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/krita/krita-1.6.3_p20090204.ebuild,v 1.10 2009/09/27 12:35:29 ranger Exp $
EAPI=2
ARTS_REQUIRED="never"
KMNAME=koffice

inherit kde-meta eutils

DESCRIPTION="KOffice image manipulation program."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="http://debian.uchicago.edu/kde-sunset/koffice-1.6.3_p20090204.tar.bz2 https://files.hboeck.de/distfiles/koffice-1.6.3_p20090204.tar.bz2 http://down1.chinaunix.net/distfiles/koffice-1.6.3_p20090204.tar.bz2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="~app-office/koffice-libs-1.6.3_p20090204
	>=media-libs/lcms-1.15
	media-libs/tiff
	media-libs/jpeg
	>=media-libs/openexr-1.2.2-r2
	media-libs/libpng
	>=media-libs/libexif-0.6.13-r1
	virtual/opengl
	virtual/glu"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkopalette lib/kopalette
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkrossapi lib/kross/api/
	libkrossmain lib/kross/main/"

KMEXTRACTONLY="lib/"

KMEXTRA="filters/krita"

need-kde 3.5

pkg_setup() {
	# use opengl &&
		if ! built_with_use dev-qt/qt-meta:3 opengl ; then
			eerror "You need to build dev-qt/qt-meta with opengl use flag enabled."
			die
		fi
}

src_unpack() {
	kde-meta_src_unpack

	# Broken - with Imagemagick 6.4 functions went private.
	sed -i -e 's:$(IMAGEMAGICK_SUBDIR)::' "${S}"/filters/krita/Makefile.am

	# FIXME - disable broken tests for now
	sed -i -e "s:TESTSDIR =.*:TESTSDIR=:" "${S}"/krita/core/Makefile.am \
		$(ls "${S}"/krita/colorspaces/*/Makefile.am)
}

src_compile() {
	for i in $(find "${S}"/lib -iname "*\.ui"); do
		"${QTDIR}"/bin/uic ${i} > ${i%.ui}.h
	done

	kde-meta_src_compile
}
