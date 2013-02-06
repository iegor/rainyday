# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE: Web browser, file manager, ..."
IUSE="branding java kdehiddenvisibility"

DEPEND="=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	=kde-base/kcontrol-${PV}:${SLOT}
	=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	=kde-base/kfind-${PV}:${SLOT}
	java? ( virtual/jre )"

pkg_preinst() {
	kde_pkg_preinst

	# We need to symlink here, as kfmclient freaks out completely,
	# if it does not find konqueror.desktop in the legacy path.
	dodir "${PREFIX}"/share/applications/kde
	dosym ../../applnk/konqueror.desktop "${PREFIX}"/share/applications/kde/konqueror.desktop
}

src_install() {
	kde_src_install

	if use branding ; then
		dodir "${PREFIX}"/share/services/searchproviders
		insinto "${PREFIX}"/share/services/searchproviders
		doins "${WORKDIR}"/patches/Gentoo_{Forums,Bugzilla}.desktop
	fi
}

pkg_postinst() {
	kde_pkg_postinst

	if use branding ; then
		echo
		elog "We've added Gentoo-related web shortcuts:"
		elog "- gb           Gentoo Bugzilla searching"
		elog "- gf           Gentoo Forums searching"
#		elog "- gp           Gentoo Package searching"
		elog "- yyt						youtube secure searching"
		elog "- ggs						google secure searching"
		elog "- exua					ex.ua searching"
		echo
		elog "You'll have to activate them in 'Configure Konqueror...'."
	fi
	echo
	elog "If you can't open new Konqueror windows and get something like"
	elog "'WARNING: Outdated database found' when starting Konqueror in a console, run"
	elog "kbuildsycoca as the user you're running KDE under."
	elog "This is NOT a bug."
	echo
}
