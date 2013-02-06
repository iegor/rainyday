# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
RESTRICT="binchecks strip"
KMNAME=kdesdk
inherit kde-meta eutils
DESCRIPTION="[GIT] A shell script that will create the necessary framework to develop various KDE applications."
IUSE=""

src_install() {
	kde-meta_src_install
	for f in ${KDEDIR}/share/apps/kapptemplate/admin/{bcheck,conf.change,config,detect-autoconf}.pl ; do
		fperms 755 ${f}
	done
}
