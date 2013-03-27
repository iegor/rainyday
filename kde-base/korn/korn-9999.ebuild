# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE mailbox checker"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/mimelib-${PV}:${SLOT}
=kde-base/libkmime-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	|| ( =kde-base/kdebase-kioslaves-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )
	=kde-base/kdepim-kioslaves-${PV}:${SLOT}"

KMCOPYLIB="libmimelib mimelib
	libkmime libkmime"
# libkcal is installed because a lot of headers are needed, but it doesn't have to be compiled
KMEXTRACTONLY="
	mimelib/
	libkmime/
	libkdenetwork/"
