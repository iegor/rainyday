# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-meta/kdesdk-meta-3.5.10.ebuild,v 1.6 2009/07/12 12:16:53 armin76 Exp $

EAPI=2
SLOT=0
inherit kde-functions
DESCRIPTION="[GIT] kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="develop subversion elibc_glibc"

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
	>=kde-misc/kdiff3-0.9.92
	=kde-base/kspy-${PV}:${SLOT}
	=kde-base/kuiviewer-${PV}:${SLOT}
	=kde-base/umbrello-${PV}:${SLOT}
	develop? (
		=dev-util/kdevelop-${PV}
		>=dev-util/kdbg-2.2.0
	)"
