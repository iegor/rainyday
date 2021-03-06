# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun/noatun-3.5.10.ebuild,v 1.6 2009/07/12 12:13:31 armin76 Exp $
EAPI="1"
KMNAME=kdemultimedia
inherit kde-meta eutils flag-o-matic

DESCRIPTION="A modular media player for KDE, featuring audio effects, graphic equalizer and network transparency."
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=kde-base/kdemultimedia-arts-${PV}:${SLOT}"
DEPEND="${RDEPEND}
	x11-libs/libXext"

KMCOMPILEONLY="arts"

src_compile() {
	# fix bug 128884
	filter-flags -fomit-frame-pointer
	kde-meta_src_compile
}
