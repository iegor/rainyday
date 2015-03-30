# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-9999.ebuild,v 1.3 2014/09/16 19:23:43 jer Exp $

EAPI=5
EGIT_REPO_URI=${EGIT_REPO_URI:="git://git.suckless.org/surf"}
EGIT_BRANCH=${EGIT_BRANCH:=master}
inherit eutils git-support savedconfig toolchain-funcs
DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="
	dev-libs/glib
	net-libs/libsoup
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libX11
"
DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	!sci-chemistry/surf
	${COMMON_DEPEND}
	x11-apps/xprop
	x11-misc/dmenu
	!savedconfig? (
		net-misc/curl
		x11-terms/st
	)
"

pkg_setup() {
	if ! use savedconfig; then
		elog "The default config.h assumes you have"
		elog " net-misc/curl"
		elog " x11-terms/st"
		elog "installed to support the download function."
		elog "Without those, downloads will fail (gracefully)."
		elog "You can fix this by:"
		elog "1) Installing these packages, or"
		elog "2) Setting USE=savedconfig and changing config.h accordingly."
	fi

	if [ -f "${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${P}" ]; then
		ebegin "Backing up old saved_config file"
			mv "${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${P}" \
			"${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/bup.${P}"
		eend ${?}
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch_user
	restore_config config.def.h
	tc-export CC PKG_CONFIG
}

src_install() {
	default
	save_config config.h
}
