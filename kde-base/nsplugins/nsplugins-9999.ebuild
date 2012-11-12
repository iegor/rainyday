# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.10.ebuild,v 1.7 2009/07/12 11:17:11 armin76 Exp $
EAPI=2
KMNAME=kdebase
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] Netscape plugins support for Konqueror."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" \
		"${S}/nsplugins/Makefile.am" || die "sed failed"
}
