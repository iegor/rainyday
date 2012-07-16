# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkholidays/libkholidays-3.5.10.ebuild,v 1.7 2009/07/12 09:30:26 armin76 Exp $
EAPI="1"
KMNAME=kdepim
inherit kde-meta eutils

DESCRIPTION="KDE library to compute holidays."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

PATCHES=( "${FILESDIR}/${KMNAME}_${PN}-r938036.patch" )
