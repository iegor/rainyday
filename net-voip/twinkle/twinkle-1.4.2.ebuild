# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit autotools eutils qt3

DESCRIPTION="Softphone for VoIP communcations using SIP protocol"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="speex ilbc zrtp"

RDEPEND=">=net-libs/ccrtp-1.6.0
	dev-cpp/commoncpp2
	x11-libs/qt:3
	media-libs/libsndfile
	dev-libs/boost
	speex? ( media-libs/speex )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( >=net-libs/libzrtpcpp-1.3.0 )
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.1-kdedetect.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--without-kde \
		$(use_with ilbc) \
		$(use_with speex) \
		$(use_with zrtp) \
		--without-arts
}

src_install() {
	emake DESTDIR="${D}" install || die
	domenu twinkle.desktop || die
	dodoc AUTHORS ChangeLog NEWS README THANKS || die
}
