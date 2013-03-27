# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMMODULE=kresources
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE PIM groupware plugin collection"
IUSE=""
DEPEND="=kde-base/libkmime-${PV}:${SLOT}
	=kde-base/libkcal-${PV}:${SLOT}
	=kde-base/libkpimexchange-${PV}:${SLOT}
	=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/kaddressbook-${PV}:${SLOT}
	=kde-base/kode-${PV}:${SLOT}
	=kde-base/ktnef-${PV}:${SLOT}
	dev-libs/libical
	>=app-crypt/gpgme-1.3.1"
RDEPEND="${DEPEND}"

# Tests fail due to a missing file (kde-features_parser.custom.h) which
# is not in the kdepim tarball.
RESTRICT="test"

KMCOPYLIB="
	libkmime libkmime
	libkcal libkcal
	libkpimexchange libkpimexchange
	libkdepim libkdepim
	libkabinterfaces kaddressbook/interfaces/"

KMEXTRACTONLY="
	korganizer/
	libkpimexchange/configure.in.in
	libkdepim/
	kmail/kmailicalIface.h
	libkpimexchange/
	libemailfunctions/
	libkmime/kmime_util.h"

KMCOMPILEONLY="
	knotes/
	libkcal/
	kaddressbook/common/"

src_configure() {
	export DO_NOT_COMPILE="knotes libkcal"
	kde-meta_src_configure
}

src_compile() {
	cd knotes/; make libknotesresources.la || die
	cd "${S}"/libkcal/libical/src/libical ; emake ical.h
	kde-meta_src_compile
}
