# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-3.5.10.ebuild,v 1.7 2009/07/12 11:37:13 armin76 Exp $
EAPI="1"
KMNAME=kdebase

inherit kde-meta eutils

DESCRIPTION="KDE file find utility"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkonq libkonq"
KDE_DOWNLOAD_SOURCE="git"