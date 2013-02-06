# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMCOPYLIB="libkonq libkonq/"
KMEXTRACTONLY="kcheckpass/kcheckpass.h
	libkonq/
	kdm/kfrontend/themer/
	kioslave/thumbnail/configure.in.in" # for the HAVE_LIBART test
KMCOMPILEONLY="kcontrol/background
	kdmlib/"
KMNODOCS=true
inherit kde-meta eutils
DESCRIPTION="[GIT] KDesktop is the KDE interface that handles the icons, desktop popup menus and screensaver system."
IUSE="kdehiddenvisibility xscreensaver"

DEPEND="x11-libs/libXext
	x11-libs/libXcursor
	=kde-base/libkonq-${PV}:${SLOT}
	=kde-base/kcontrol-${PV}:${SLOT}
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	=kde-base/kcheckpass-${PV}:${SLOT}
	=kde-base/kdialog-${PV}:${SLOT}
	=kde-base/konqueror-${PV}:${SLOT}
	xscreensaver? ( x11-libs/libXScrnSaver )"

src_unpack() {
	kde-meta_src_unpack
	# see bug #143375
	sed  -e "s:SUBDIRS = . lock pics patterns programs init:SUBDIRS = . lock pics patterns programs:" \
		-i kdesktop/Makefile.am
}

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"
	kde-meta_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	dodir "${PREFIX}"/share/templates/.source/emptydir
}
