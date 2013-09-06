# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit autotools eutils versionator games git-2

MY_PV=$(get_version_component_range -2)
VIDEOS_PV=9999
VIDEOS_P=${PN}-videos-${VIDEOS_PV}.wz
DESCRIPTION="[GIT] 3D real-time strategy game"
HOMEPAGE="http://wz2100.net/"
SRC_URI="videos? ( http://downloads.sourceforge.net/project/warzone2100/warzone2100/Videos/high-quality-en/sequences.wz -> ${PN}-vidsequences.wz )"
EGIT_REPO_URI="git://github.com/Warzone2100/warzone2100.git"
EGIT_BRANCH="master"
LICENSE="GPL-2 CCPL-Attribution-ShareAlike-3.0 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
# upstream requested debug support
IUSE="debug nls videos"

RDEPEND="dev-db/sqlite:3
	>=dev-games/physfs-2[zip]
	dev-libs/popt
	media-libs/libogg
	media-libs/libpng
	media-libs/libsdl[opengl,video]
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-net
	media-libs/quesoglc
	virtual/glu
	virtual/opengl
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/bison
	app-arch/zip
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
RDEPEND="${RDEPEND}
	media-fonts/dejavu"

src_prepare() {
	sed -i \
		-e 's/#top_builddir/top_builddir/' \
		po/Makevars || die "can't do sed"

	epatch "${FILESDIR}"/${PN}-pkgconf.patch

	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-motif \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF} \
		--localedir=/usr/share/locale \
		--with-distributor="Gentoo ${PF}" \
		--with-icondir=/usr/share/pixmaps \
		--with-applicationdir=/usr/share/applications \
		$(use_enable debug debug relaxed) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -f "${D}"/usr/share/doc/${PF}/COPYING*
	if use videos ; then
		insinto "${GAMES_DATADIR}"/${PN}
		newins "${DISTDIR}"/${PN}-vidsequences.wz sequences.wz || die
	fi
	doman doc/warzone2100.6
	prepgamesdirs
}
