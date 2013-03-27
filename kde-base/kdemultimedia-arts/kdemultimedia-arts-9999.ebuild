# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMMODULE=arts
KMEXTRACTONLY="mpeglib_artsplug/configure.in.in" # needed because the artsc-config call is here
KMEXTRA="doc/artsbuilder"
inherit kde-meta eutils
DESCRIPTION="[GIT] aRts pipeline builder and other tools"
IUSE="alsa"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="alsa? ( media-libs/alsa-lib )"

pkg_setup() {
	kde_pkg_setup

	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "The alsa USE flag in this package enables ALSA support"
		eerror "for libkmid, KDE midi library."
		eerror "For this reason, you have to merge media-libs/alsa-lib"
		eerror "with the midi USE flag enabled, or disable alsa USE flag"
		eerror "for this package."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
