# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="
	libkdepim libkdepim
	libkcal libkcal
	libkleopatra certmanager/lib/
	libqgpgme libkdenetwork/qgpgme/
	libkpinterfaces kontact/interfaces/"
KMEXTRACTONLY="
	libkdepim/
	libkdenetwork/
	libkcal/
	libemailfunctions/
	certmanager/
	kontact/interfaces/
	akregator
	kmail/kmailIface.h"
KMCOMPILEONLY="
	libkcal/libical/src/libical/
	libkcal/libical/src/libicalss/
	akregator/src/librss"
	# We add them here because they are standard plugins and programs related to kaddressbook but not a dep of any other kdepim program, so they will be lost if noone install them
KMEXTRA="
	kabc/
	kfile-plugins/vcf
	kontact/plugins/kaddressbook"
inherit kde-meta eutils
DESCRIPTION="[GIT] The KDE Address Book"
IUSE="gnokii"

DEPEND="
=kde-base/libkdepim-${PV}:${SLOT}
=kde-base/libkcal-${PV}:${SLOT}
=kde-base/certmanager-${PV}:${SLOT}
=kde-base/libkdenetwork-${PV}:${SLOT}
=kde-base/kontact-${PV}:${SLOT}
gnokii? ( app-mobilephone/gnokii )"
RDEPEND="${DEPEND}"

src_compile() {
	myconf="$(use_with gnokii) --enable-newdistrlists"
	export DO_NOT_COMPILE="libical" && kde-meta_src_compile myconf configure
	# generate "ical.h"
	cd "${S}/libkcal/libical/src/libical" && make ical.h
	# generate "icalss.h"
	cd "${S}/libkcal/libical/src/libicalss" && make icalss.h

	kde-meta_src_compile make
}
