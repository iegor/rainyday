# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMCOMPILEONLY="arts"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE sound recorder"
IUSE="encode mp3 vorbis"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/kdemultimedia-arts-${PV}:${SLOT}
	encode? ( mp3? ( media-sound/lame )
			vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"

src_compile() {
	if use encode; then
		myconf="$(use_with mp3 lame) $(use_with vorbis)"
	else
		myconf="--without-lame --without-vorbis"
	fi

	kde-meta_src_compile
}
