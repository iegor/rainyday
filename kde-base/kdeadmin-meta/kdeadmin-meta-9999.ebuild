# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdeadmin - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE=""

RDEPEND="=kde-base/kcron-${PV}:${SLOT}
	=kde-base/kdeadmin-kfile-plugins-${PV}:${SLOT}
	=kde-base/kuser-${PV}:${SLOT}
	x86? ( =kde-base/lilo-config-${PV}:${SLOT} )
	amd64? ( =kde-base/lilo-config-${PV}:${SLOT} )
	=kde-base/secpolicy-${PV}:${SLOT}
	=kde-base/knetworkconf-${PV}:${SLOT}"

# NOTE: KPackage, KSysv are useless on a normal gentoo system and so aren't included
# in the above list. KDat is broken and unmaintained. However, packages do nominally
# exist for them.
