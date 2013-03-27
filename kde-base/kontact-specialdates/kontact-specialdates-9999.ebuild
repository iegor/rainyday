# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMNOMODULE=true
inherit kde-meta eutils
DESCRIPTION="[GIT] Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/kontact-${PV}:${SLOT}
	=kde-base/kaddressbook-${PV}:${SLOT}
	=kde-base/korganizer-${PV}:${SLOT}
	=kde-base/libkholidays-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	=kde-base/libkdepim-${PV}:${SLOT}"

KMCOPYLIB="libkdepim libkdepim/
	libkpinterfaces kontact/interfaces
	libkaddressbook kaddressbook
	libkorganizer_calendar korganizer
	libkholidays libkholidays"
KMEXTRACTONLY="libkholidays
	kontact/interfaces/
	kaddressbook
	korganizer
	libkdepim"
KMEXTRA="kontact/plugins/specialdates"
