EAPI=3

inherit eutils games cmake-utils versionator

DESCRIPTION="An InfiniMiner/Minecraft inspired game."
HOMEPAGE="http://celeron.55.lt/~celeron55/minetest/"


MY_PN="minetest"
MY_PV=$(replace_version_separator 3 '_')
MY_P="${PN}-${MY_PV}"

SRC_URI="https://github.com/minetest/minetest/tarball/${MY_PV} -> ${MY_P}.tar.gz"

TAG_HASH="bc0e5c0"

S="${WORKDIR}/celeron55-minetest-$TAG_HASH"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+client nls +server"

DEPEND="sys-libs/zlib
		nls? ( sys-devel/gettext )
		>=dev-games/irrlicht-1.7
		x11-libs/libX11
		virtual/opengl
		app-arch/bzip2
		media-libs/libpng
		dev-db/sqlite:3
		=dev-libs/jthread-1.2.1-r1
		"
RDEPEND="${DEPEND}"

src_configure() {
	# we redesignate installation paths to the games prefix and
	# intentionally break project supplied jthread and sqlite source
	sed -i -e "s|set(BINDIR \"bin|set(BINDIR \"games/bin|g" \
		-e "s|set(DATADIR \"share/|set(DATADIR \"share/games/|g" \
		-e "/^if (SQLITE/,/^endif (SQLITE/d" \
		-e "/^if (JTHREAD/,/^endif (JTHREAD/d" \
		CMakeLists.txt || die "games prefix paths not reset"

	# we also need to redesignate the language file location since
	# it shouldn't live in /usr/share/games/locale..
	sed -i -e \
	"s|GETTEXT_MO_DEST_PATH \${DATADIR}/|GETTEXT_MO_DEST_PATH \${DATADIR}/../|g" \
		cmake/Modules/FindGettextLib.cmake || die "locale path not reset"

	mycmakeargs="
		-DRUN_IN_PLACE=0
		-DJTHREAD_INCLUDE_DIR=${EROOT}/usr/include/jthread
		$(cmake-utils_use_build client CLIENT)
		$(cmake-utils_use_build server SERVER)
		$(cmake-utils_use_use nls GETTEXT)"

	cmake-utils_src_configure
}

src_prepare() {
	# these should not be used during building anyway so we delete them
	rm -rf src/{jthread,sqlite}
	# default texture path reset to games prefix
	epatch "${FILESDIR}"/fix-texture-path-$MY_PV.patch
}

pkg_preinst() {
	enewgroup minetest
	enewuser minetest -1 -1 /var/lib/minetest "minetest,games"
	mkdir -p ${D}/var/lib/minetest
	mkdir -p ${D}/etc/init.d
	chown minetest:minetest ${D}/var/lib/minetest
	cp "${FILESDIR}"/minetestserver.init ${D}/etc/init.d/minetestserver
}

