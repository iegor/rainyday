# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
inherit kde-meta eutils
DESCRIPTION="[GIT] KBugBuster - A tool for checking and reporting KDE apps' bugs"
IUSE="kcal kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="kcal? ( || ( =kde-base/libkcal-${PV}:${SLOT} =kde-base/kdepim-${PV}:${SLOT} ) )"

#TODO tell configure about the optional kcal support, or something
