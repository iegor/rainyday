# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-3.5.10.ebuild,v 1.8 2009/10/20 16:55:18 ssuominen Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
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
