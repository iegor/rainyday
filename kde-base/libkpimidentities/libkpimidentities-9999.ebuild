# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE PIM identities library"
IUSE=""

DEPEND="=kde-base/certmanager-${PV}:${SLOT}
		=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/libkmime-${PV}:${SLOT}"
