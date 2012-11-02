# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-3.5.10.ebuild,v 1.8 2009/07/12 10:27:04 armin76 Exp $
EAPI="1"
KMNAME=kdenetwork

inherit kde-meta eutils

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KDE_DOWNLOAD_SOURCE="git"

DEPEND="x11-libs/libXext"
