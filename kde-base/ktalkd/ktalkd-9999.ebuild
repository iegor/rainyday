# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE talk daemon"
IUSE="kdehiddenvisibility"

KMEXTRA="doc/kcontrol/kcmktalkd"

RDEPEND="|| ( net-misc/netkit-talk net-misc/ytalk sys-freebsd/freebsd-ubin )"

pkg_postinst() {
	kde_pkg_postinst

	if has_version net-misc/ytalk ; then
		elog "To use net-misc/ytalk as your local network chat program, please"
		elog "configure your system accordingly, either via the KDE control center"
		elog "or by calling \"kcmshell kcmktalkd\" on the command line."
	fi
}
