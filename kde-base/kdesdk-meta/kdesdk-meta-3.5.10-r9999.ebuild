# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-meta/kdesdk-meta-3.5.10.ebuild,v 1.6 2009/07/12 12:16:53 armin76 Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="develop subversion elibc_glibc"

RDEPEND="
	=kde-base/cervisia-${PVR}:${SLOT}
	=kde-base/kapptemplate-${PVR}:${SLOT}
	=kde-base/kbabel-${PVR}:${SLOT}
	=kde-base/kbugbuster-${PVR}:${SLOT}
	=kde-base/kcachegrind-${PVR}:${SLOT}
	=kde-base/kdesdk-kfile-plugins-${PVR}:${SLOT}
	=kde-base/kdesdk-misc-${PVR}:${SLOT}
	=kde-base/kdesdk-scripts-${PVR}:${SLOT}
	elibc_glibc? ( =kde-base/kmtrace-${PVR}:${SLOT} )
	=kde-base/kompare-${PVR}:${SLOT}
	=kde-base/kspy-${PVR}:${SLOT}
	=kde-base/kuiviewer-${PVR}:${SLOT}
	subversion? ( =kde-base/kdesdk-kioslaves-${PVR}:${SLOT} )
	=kde-base/umbrello-${PVR}:${SLOT}
	develop? ( =dev-util/kdevelop-3.5.4-${PR}:${SLOT}
	=dev-util/codeblocks-9999 )"
