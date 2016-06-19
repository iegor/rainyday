# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kexi/kexi-1.6.3_p20090204.ebuild,v 1.8 2009/09/27 12:30:31 ranger Exp $
EAPI=2
ARTS_REQUIRED="never"

KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice integrated environment for database management."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="http://debian.uchicago.edu/kde-sunset/koffice-1.6.3_p20090204.tar.bz2 https://files.hboeck.de/distfiles/koffice-1.6.3_p20090204.tar.bz2 http://down1.chinaunix.net/distfiles/koffice-1.6.3_p20090204.tar.bz2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="mysql postgres"

DEPEND="~app-office/koffice-libs-1.6.3_p20090204
	sys-libs/readline
	mysql? ( virtual/mysql )
	postgres? ( =dev-libs/libpqxx-2.6* )"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoproperty lib/koproperty
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkrossmain lib/kross/main/
	libkrossapi lib/kross/api/"

KMEXTRACTONLY="lib/"

need-kde 3.5

src_compile() {
	local myconf="$(use_enable mysql) $(use_enable postgres pgsql) --enable-kexi-reports"

	kde-meta_src_compile
}
