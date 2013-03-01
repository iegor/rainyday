# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="
	libkdepim libkdepim/
	libkpimidentities libkpimidentities/
	libmimelib mimelib/
	libksieve libksieve/
	libkleopatra certmanager/lib/
	libkcal libkcal
	libkpinterfaces kontact/interfaces/
	libkmime libkmime
	libkpgp libkpgp"
KMEXTRACTONLY="
	libkdenetwork/
	libkdepim/
	libkpimidentities/
	libksieve/
	libkcal/
	mimelib/
	certmanager/
	korganizer/korganizeriface.h
	korganizer/kcalendariface.h
	kontact/interfaces/
	libkmime/
	libkpgp
	dcopidlng"
KMCOMPILEONLY="libemailfunctions"
# the kmail plugins are installed with kmail
KMEXTRA="plugins/kmail/"
# We add here the kontact's plugin instead of compiling
# it with kontact because it needs a lot of this programs deps.
KMEXTRA="${KMEXTRA} kontact/plugins/kmail/"
inherit kde-meta eutils
RESTRICT="test"
DESCRIPTION="[GIT] KMail is the email component of Kontact, the integrated personal information manager of KDE."
IUSE="crypt"

DEPEND="=kde-base/libkdenetwork-${PV}:${SLOT}
	=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/libkpimidentities-${PV}:${SLOT}
	=kde-base/mimelib-${PV}:${SLOT}
	=kde-base/libksieve-${PV}:${SLOT}
	=kde-base/certmanager-${PV}:${SLOT}
	=kde-base/libkcal-${PV}:${SLOT}
	=kde-base/kontact-${PV}:${SLOT}
	=kde-base/libkpgp-${PV}:${SLOT}
	=kde-base/libkmime-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/pinentry )
	=kde-base/kdepim-kioslaves-${PV}:${SLOT}
	=kde-base/kmailcvt-${PV}:${SLOT}
	|| ( =kde-base/kdebase-kioslaves-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )
	|| ( =kde-base/kcontrol-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )" # for the "looknfeel" icon, and probably others.

src_install() {
	kde-meta_src_install
	# Install KMail icons with libkdepim to work around bug #136810.
	#find ${D}/${KDEDIR}/share/icons/hicolor/ -name "kmail\.png" -exec rm '{}' \;
	rm "${D}/${KDEDIR}"/share/icons/hicolor/{16x16,22x22,32x32,48x48,64x64,128x128}/apps/kmail.png || die "deleting kmail.png failed"
}
