# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystraycmd/ksystraycmd-3.5.10-r1.ebuild,v 1.5 2009/07/24 15:33:55 josejx Exp $
EAPI="1"
KMNAME=kdebase

inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="[GIT] ksystraycmd embeds applications given as argument into the system tray."
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KDE_DOWNLOAD_SOURCE="git"

PATCHES=( "${FILESDIR}/${PN}-3.5-transparency.diff" )
