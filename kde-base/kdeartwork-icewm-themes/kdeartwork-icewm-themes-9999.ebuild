# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
RESTRICT="binchecks strip"
KMMODULE=icewm-themes
KMNAME=kdeartwork
inherit kde-meta
DESCRIPTION="[GIT] Themes for IceWM from the kdeartwork package."
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=""
RDEPEND="=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}"

pkg_postinst() {
	kde_pkg_postinst
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
