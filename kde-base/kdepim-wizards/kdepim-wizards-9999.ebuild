# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMMODULE=wizards
inherit kde-meta eutils
DESCRIPTION="[GIT] KDEPIM wizards"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="
	=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/libkmime-${PV}:${SLOT}
	=kde-base/libkcal-${PV}:${SLOT}
	=kde-base/certmanager-${PV}:${SLOT}
	=kde-base/kdepim-kresources-${PV}:${SLOT}
	=kde-base/libkpimidentities-${PV}:${SLOT}
	=kde-base/kaddressbook-${PV}:${SLOT}
"

#RESTRICT="test"

KMCOPYLIB="
	libkcal libkcal
	libkmime libkmime
	libkdepim libkdepim
	libkpimidentities libkpimidentities
	libkabc_xmlrpc kresources/egroupware
	libkcal_xmlrpc kresources/egroupware
	libknotes_xmlrpc kresources/egroupware
	libkcal_slox kresources/slox
	libkabc_slox kresources/slox
	libkcal_groupwise kresources/groupwise
	libkabc_groupwise kresources/groupwise
	libkcalkolab kresources/kolab/kcal
	libkabckolab kresources/kolab/kabc
	libknoteskolab kresources/kolab/knotes
	libkcal_newexchange kresources/newexchange
	libkabc_newexchange kresources/newexchange
	libkabcscalix kresources/scalix/kabc
	libkcalscalix kresources/scalix/kcal
	libknotesscalix kresources/scalix/knotes
	libkabinterfaces kaddressbook/interfaces
	libgwsoap kresources/groupwise/soap
"

KMEXTRACTONLY="
	libkdepim/
	libkcal/
	libkpimidentities/
	kresources/
	knotes/
	certmanager/lib/
	kmail
	libkmime/kmime_util.h"

KMCOMPILEONLY="
	knotes
	kaddressbook/common
	libkcal/libical/src/libical
	kresources/slox
	kresources/groupwise
	kresources/egroupware
	kresources/lib
	libemailfunctions
"

src_compile() {
	export DO_NOT_COMPILE="kresources" && kde-meta_src_compile myconf configure

	# generate headers
	cd "${S}/kresources/slox" && make kabcsloxprefs.h
	cd "${S}/kresources/slox" && make kcalsloxprefs.h
	cd "${S}/kresources/groupwise" && make kabc_groupwiseprefs.h
	cd "${S}/kresources/groupwise" && make kcal_groupwiseprefsbase.h
	cd "${S}/kresources/egroupware" && make kcal_egroupwareprefs.h
	cd "${S}/kresources/egroupware" && make kabc_egroupwareprefs.h
	cd "${S}/kresources/egroupware" && make knotes_egroupwareprefs.h
	cd "${S}/kresources/lib" && make kresources_groupwareprefs.h

	kde-meta_src_compile make
}
