# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-1.6.3_p20090204.ebuild,v 1.9 2009/09/27 12:36:06 ranger Exp $
EAPI=2
ARTS_REQUIRED="never"
KMNAME=koffice

inherit kde-meta eutils

DESCRIPTION="KOffice spreadsheet application."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="http://debian.uchicago.edu/kde-sunset/koffice-1.6.3_p20090204.tar.bz2 https://files.hboeck.de/distfiles/koffice-1.6.3_p20090204.tar.bz2 http://down1.chinaunix.net/distfiles/koffice-1.6.3_p20090204.tar.bz2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="~app-office/koffice-libs-1.6.3_p20090204
	~app-office/kchart-1.6.3_p20090204
	~app-office/kexi-1.6.3_p20090204"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkochart interfaces
	libkrossmain lib/kross/main
	libkrossapi lib/kross/api
	libkexidb kexi/kexidb
	libkexidbparser kexi/kexidb/parser"

KMEXTRACTONLY="lib/
	interfaces/
	filters/kexi
	kexi/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kspread"

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-1.6.3-gcc44.patch" )

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile liboofilter first
	echo "SUBDIRS = liboofilter kspread" > "${S}"/filters/Makefile.am

	# Work around broken conditional
	echo "SUBDIRS = applixspread csv dbase gnumeric latex opencalc html qpro excel kexi" > "${S}"/filters/kspread/Makefile.am

	for i in $(find "${S}"/lib -iname "*\.ui"); do
		"${QTDIR}"/bin/uic ${i} > ${i%.ui}.h
	done

	kde-meta_src_unpack makefiles
}
