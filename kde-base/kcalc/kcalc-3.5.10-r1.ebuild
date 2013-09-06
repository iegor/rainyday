# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-3.5.10.ebuild,v 1.7 2009/07/12 10:02:20 armin76 Exp $

EAPI="1"
KMNAME=kdeutils
inherit kde-meta eutils

DESCRIPTION="KDE Calculator"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="dev-libs/gmp"

PATCHES=( "${FILESDIR}/${KMNAME}_${PN}-r894668.patch" )
