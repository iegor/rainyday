# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] A tool to create interactive applets for the KDE desktop."
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
