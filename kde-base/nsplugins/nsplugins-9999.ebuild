# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] Netscape plugins support for Konqueror."
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" \
		"${S}/nsplugins/Makefile.am" || die "sed failed"
}
