# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE Time tracker tool"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RESTRICT="test"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkcal_resourceremote kresources/remote"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kresources/remote"

RDEPEND="=kde-base/libkcal-${PV}:${SLOT}
	=kde-base/kdepim-kresources-${PV}:${SLOT}
	=kde-base/libkdepim-${PV}:${SLOT}
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto"
