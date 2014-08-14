# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

GIT_ECLASS=
if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS=git-2
fi

inherit eutils fdo-mime toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="A minimalist web browser with sophisticated security features designed-in"
HOMEPAGE="https://opensource.conformal.com/wiki/xombrero"

KEYWORDS=""
if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://opensource.conformal.com/${PN}.git
		https://opensource.conformal.com/git/${PN}.git"
	EGIT_SOURCEDIR="${WORKDIR}/${P}"
else
	SRC_URI="http://opensource.conformal.com/snapshots/${PN}/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="branding examples gtk3"

RDEPEND="dev-libs/glib:2
	dev-libs/libbsd
	dev-libs/libgcrypt
	net-libs/libsoup
	net-libs/gnutls
	x11-libs/gdk-pixbuf
	x11-libs/pango
	gtk3? ( net-libs/webkit-gtk:3 x11-libs/gtk+:3 )
	!gtk3? ( net-libs/webkit-gtk:2 x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-libs/atk
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:0
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/pixman"

S="${WORKDIR}/${P}/linux"

src_prepare() {
	sed -i \
		-e 's/-O2//' \
		-e 's/-ggdb3//' \
		Makefile || die 'sed failed.'
	use branding && for myfile in ../xombrero.h ../xombrero.conf ; do
	sed -i \
		-e 's#https://www\.cyphertite\.com#http://www.gentoo.org#' \
		"${myfile}" || die 'sed failed.'
	done
	for myfile in ../playflash.sh ../Makefile ../xombrero.conf ../unix.c Makefile ; do
		sed -i \
			-e "s#/usr/local#/usr#" \
			"${myfile}" || die 'sed failed.'
	done
	sed -i \
		"s#Icon=#Icon=/usr/share/${PN}/#" \
		../xombrero.desktop || die 'sed failed.'
}

src_configure() {
	use gtk3 || export GTK_VERSION="gtk2"
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf
	fi
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDADD="${LDFLAGS}" emake
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX=/usr \
		install

	insinto "/usr/share/${PN}"
	doins ../*.png ../style.css

	insinto /usr/share/applications
	doins ../${PN}.desktop

	doman ../${PN}.1

	if use examples;then
		insinto "/usr/share/doc/${PF}/examples"
		doins \
			../${PN}.conf \
			../playflash.sh \
			../favorites
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
