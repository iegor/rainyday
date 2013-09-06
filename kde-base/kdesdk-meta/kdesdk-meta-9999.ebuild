# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE="subversion elibc_glibc"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="
	=kde-base/cervisia-${PV}:${SLOT}
	=kde-base/kapptemplate-${PV}:${SLOT}
	=kde-base/kbabel-${PV}:${SLOT}
	=kde-base/kbugbuster-${PV}:${SLOT}
	=kde-base/kcachegrind-${PV}:${SLOT}
	=kde-base/kdesdk-kfile-plugins-${PV}:${SLOT}
	subversion? ( =kde-base/kdesdk-kioslaves-${PV}:${SLOT} )
	=kde-base/kdesdk-misc-${PV}:${SLOT}
	=kde-base/kdesdk-scripts-${PV}:${SLOT}
	elibc_glibc? ( =kde-base/kmtrace-${PV}:${SLOT} )
	=kde-base/kompare-${PV}:${SLOT}
	=kde-base/kspy-${PV}:${SLOT}
	=kde-base/kuiviewer-${PV}:${SLOT}
	=kde-base/umbrello-${PV}:${SLOT}"
