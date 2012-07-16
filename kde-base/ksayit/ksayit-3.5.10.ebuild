# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksayit/ksayit-3.5.10.ebuild,v 1.6 2009/07/12 13:36:50 armin76 Exp $
EAPI="1"
KMNAME=kdeaccessibility

inherit kde-meta

DESCRIPTION="KDE text-to-speech frontend."
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=kde-base/kttsd-${PV}:${SLOT}
	>=kde-base/kdemultimedia-arts-${PV}:${SLOT}"

src_compile() {
	myconf="--enable-ksayit-audio-plugins"
	kde-meta_src_compile
}
