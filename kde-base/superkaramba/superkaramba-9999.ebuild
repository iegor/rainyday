# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-3.5.10.ebuild,v 1.9 2009/07/12 11:21:00 armin76 Exp $

EAPI=2
KMNAME=kdeutils
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="!x11-misc/superkaramba"

pkg_setup() {
	if ! built_with_use dev-lang/python threads ; then
		eerror "superkarambe needs dev-lang/python built with threads USE flag."
		eerror "Please enable this USE flag and re-install dev-lang/python."
		die "dev-lang/python needs to be rebuilt with threads support."
	fi

	kde_pkg_setup
}
