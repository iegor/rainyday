# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE="wifi"

RDEPEND="=kde-base/dcoprss-${PVR}:${SLOT}
	=kde-base/kdenetwork-filesharing-${PVR}:${SLOT}
	=kde-base/kdict-${PVR}:${SLOT}
	=kde-base/kget-${PVR}:${SLOT}
	=kde-base/knewsticker-${PVR}:${SLOT}
	=kde-base/kopete-${PVR}:${SLOT}
	=kde-base/kpf-${PVR}:${SLOT}
	=kde-base/kppp-${PVR}:${SLOT}
	=kde-base/krdc-${PVR}:${SLOT}
	=kde-base/krfb-${PVR}:${SLOT}
	=kde-base/ktalkd-${PVR}:${SLOT}
	wifi? ( =kde-base/kwifimanager-${PVR}:${SLOT} )
	=kde-base/librss-${PVR}:${SLOT}
	=kde-base/kdnssd-${PVR}:${SLOT}
	=kde-base/kdenetwork-kfile-plugins-${PVR}:${SLOT}
	=kde-base/lisa-${PVR}:${SLOT}"
