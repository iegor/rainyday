# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/kchart-1.6.3_p20090204.ebuild,v 1.8 2009/09/27 12:29:53 ranger Exp $
EAPI=2
ARTS_REQUIRED="never"

KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice integrated graph and chart drawing tool."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="http://debian.uchicago.edu/kde-sunset/koffice-1.6.3_p20090204.tar.bz2 https://files.hboeck.de/distfiles/koffice-1.6.3_p20090204.tar.bz2 http://down1.chinaunix.net/distfiles/koffice-1.6.3_p20090204.tar.bz2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="~app-office/koffice-libs-1.6.3_p20090204"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkochart interfaces"

KMEXTRACTONLY="lib/
	interfaces/"

KMEXTRA="filters/kchart"

KMCOMPILEONLY="filters/libdialogfilter"

need-kde 3.5

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile liboofilter first
	echo "SUBDIRS = libdialogfilter kchart" > "$S"/filters/Makefile.am

	kde-meta_src_unpack makefiles
}
