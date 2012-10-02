# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-3.5.10.ebuild,v 1.8 2009/08/09 21:03:44 zmedico Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdebase - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=kde-base/kdebase-startkde-${PVR}:${SLOT}
>=kde-base/drkonqi-${PVR}:${SLOT}
>=kde-base/kappfinder-${PVR}:${SLOT}
>=kde-base/kate-${PVR}:${SLOT}
>=kde-base/kcheckpass-${PVR}:${SLOT}
>=kde-base/kcminit-${PVR}:${SLOT}
>=kde-base/kcontrol-${PVR}:${SLOT}
>=kde-base/kdcop-${PVR}:${SLOT}
>=kde-base/kdebugdialog-${PVR}:${SLOT}
>=kde-base/kdepasswd-${PVR}:${SLOT}
>=kde-base/kdeprint-${PVR}:${SLOT}
>=kde-base/kdesktop-${PVR}:${SLOT}
>=kde-base/kdesu-${PVR}:${SLOT}
>=kde-base/kdialog-${PVR}:${SLOT}
>=kde-base/kdm-${PVR}:${SLOT}
>=kde-base/kfind-${PVR}:${SLOT}
>=kde-base/khelpcenter-${PVR}:${SLOT}
>=kde-base/khotkeys-${PVR}:${SLOT}
>=kde-base/kicker-${PVR}:${SLOT}
>=kde-base/kdebase-kioslaves-${PVR}:${SLOT}
>=kde-base/klipper-${PVR}:${SLOT}
>=kde-base/kmenuedit-${PVR}:${SLOT}
>=kde-base/konqueror-${PVR}:${SLOT}
>=kde-base/konsole-${PVR}:${SLOT}
>=kde-base/kpager-${PVR}:${SLOT}
>=kde-base/kpersonalizer-${PVR}:${SLOT}
>=kde-base/kreadconfig-${PVR}:${SLOT}
>=kde-base/kscreensaver-${PVR}:${SLOT}
>=kde-base/ksmserver-${PVR}:${SLOT}
>=kde-base/ksplashml-${PVR}:${SLOT}
>=kde-base/kstart-${PVR}:${SLOT}
>=kde-base/ksysguard-${PVR}:${SLOT}
>=kde-base/ksystraycmd-${PVR}:${SLOT}
>=kde-base/ktip-${PVR}:${SLOT}
>=kde-base/kwin-${PVR}:${SLOT}
>=kde-base/kxkb-${PVR}:${SLOT}
>=kde-base/libkonq-${PVR}:${SLOT}
>=kde-base/nsplugins-${PVR}:${SLOT}
>=kde-base/knetattach-${PVR}:${SLOT}
>=kde-base/kdebase-data-${PVR}:${SLOT}"
