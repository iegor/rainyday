# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.5.10.ebuild,v 1.7 2009/07/12 13:06:57 armin76 Exp $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="
	libkleopatra certmanager/lib/
	libkdepim libkdepim/
	libkmime libkmime"
KMEXTRACTONLY="
	libkdepim/
	certmanager/
	libkmime/kmime_util.h"
KMCOMPILEONLY="
	libemailfunctions/"
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE PIM identities library"
IUSE=""

DEPEND="=kde-base/certmanager-${PV}:${SLOT}
		=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/libkmime-${PV}:${SLOT}"
