# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
inherit kde-meta
DESCRIPTION="[GIT] kmtrace - A KDE tool to assist with malloc debugging using glibc's \"mtrace\" functionality"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="sys-libs/glibc" # any other libc won't work, says the README file
RDEPEND="${DEPEND}"
