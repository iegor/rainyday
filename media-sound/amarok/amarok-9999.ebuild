# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# kde: enables compilation of the konqueror sidebar plugin

EAPI=2
KMNAME=amarok
ARTS_REQUIRED="never"
LANGS="af ar az be bg bn br ca cs cy da de el en_GB eo es et eu fa fi
fr ga gl he hi hu id is it ja km ko ku lo lt mk ms nb nds ne nl nn pa
pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn ss sv ta tg th tr uk uz
zh_CN zh_TW"
LANGS_DOC="da de es et fr it nl pl pt pt_BR ru sv"
USE_KEG_PACKAGING="1"
inherit kde
PKG_SUFFIX=""
DESCRIPTION="[GIT] Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="mp4 mysql +amazon opengl postgres visualization ipod ifp real njb mtp musicbrainz daap python"

# Blocking previous amarok-1.4:0 versions
RDEPEND="
	!<media-sound/amarok-1.4.10_p20090130-r2
	=dev-lang/ruby-1.8*
	>=media-libs/taglib-1.4
	>=media-libs/xine-lib-1.1.2_pre20060328-r8
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.5.2 )
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
	musicbrainz? ( media-libs/tunepimp )
	mysql? ( >=virtual/mysql-4.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	opengl? ( virtual/opengl )
	postgres? ( dev-db/postgresql-base )
	real? (
		media-libs/alsa-lib
		media-video/realplayer
	)
	visualization? (
		media-libs/libsdl
		=media-plugins/libvisual-plugins-0.4*
	)
"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )
	python? ( dev-python/PyQt4 )
"

need-kde 9999

src_configure() {
	# Extra, unsupported engines are forcefully disabled.
	local myconf="
		$(use_enable amazon)
		$(use_enable mysql)
		$(use_enable postgres postgresql)
		$(use_with daap)
		$(use_with ifp)
		$(use_with ipod libgpod)
		$(use_with mp4 mp4v2)
		$(use_with mtp libmtp)
		$(use_with musicbrainz)
		$(use_with njb libnjb)
		$(use_with opengl)
		$(use_with real helix)
		$(use_with visualization libvisual)
		--with-xine
		--without-nmm
	"

	kde_src_configure
}

src_install() {
	kde_src_install

	# As much as I respect Ian, I'd rather leave Amarok to use mongrel
	# from Portage, for security and policy reasons.
	rm -rf "${D}${KDEDIR}"/share/apps/amarok/ruby_lib/rbconfig \
		"${D}${KDEDIR}"/share/apps/amarok/ruby_lib/mongrel* \
		"${D}${KDEDIR}"/share/apps/amarok/ruby_lib/rubygems* \
		"${D}${KDEDIR}"/share/apps/amarok/ruby_lib/gem* \
		"${D}${KDEDIR}"/$(get_libdir)/ruby_lib

	if ! use python; then
		rm -r "${D}${KDEDIR}"/share/apps/amarok/scripts/webcontrol \
			|| die "Unable to remove webcontrol."
	fi
}
