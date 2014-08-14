# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/xombrero/xombrero-1.4.0.ebuild,v 1.2 2013/01/31 03:25:16 rafaelmartins Exp $

EAPI="4"

GIT_ECLASS=
if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS=git-2
fi

inherit eutils fdo-mime savedconfig toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="A minimalist web browser with sophisticated security features designed-in"
HOMEPAGE="http://opensource.conformal.com/wiki/xombrero"

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
IUSE="examples savedconfig"

RDEPEND="dev-libs/glib:2
	dev-libs/libbsd
	dev-libs/libgcrypt
	net-libs/libsoup
	net-libs/gnutls
	net-libs/webkit-gtk:3
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-apps/groff
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
    echo "# Set your desired start page here.
# First line not starting with # will be taken; no url check is performed." > ${PN}.conf
    echo "http://www.gentoo.org" >> ${PN}.conf
    if use savedconfig; then
        restore_config ${PN}.conf
    fi

	url=`grep -v '^#' ${PN}.conf | head -n1 | sed -e 's/#/\\#/g'`
	sed -i \
		-e 's#https://www\.cyphertite\.com#'${url}'#' \
		-e "s#/usr/local#/usr#" \
		../xombrero.h || die 'sed ../xombrero.h failed.'
	sed -i \
		-e 's/-O2//' \
		-e 's/-ggdb3//' \
		-e 's,install: all,install: all\n\tinstall -m 755 -d $(DESTDIR)$(PREFIX)/share/applications,g' \
		Makefile || die 'sed Makefile failed.'
	sed -i \
		"s#Icon=#Icon=/usr/share/${PN}/#" \
		../xombrero.desktop || die 'sed ../xombrero.desktop failed.'
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDADD="${LDFLAGS}" emake
}

src_install() {
	save_config ${PN}.conf

	emake \
		DESTDIR="${D}" \
		PREFIX=/usr \
		install

	if use examples;then
		insinto "/usr/share/doc/${PF}/examples"
		doins \
			../${PN}.conf \
			../playflash.sh \
			../favorites
	fi
}

pkg_preinst() {
	if use savedconfig; then
        ewarn 'USE=savedconfig is active. Change your start-page manually'
		ewarn 'in "'${EROOT}etc/portage/savedconfig/${CATEGORY}/${PF}'".'
    fi
}
pkg_postinst() {
	savedconfig_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
