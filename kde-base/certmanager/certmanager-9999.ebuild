# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/certmanager/certmanager-3.5.10-r1.ebuild,v 1.7 2009/08/25 14:58:48 jer Exp $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="libqgpgme libkdenetwork/qgpgme/"
KMEXTRACTONLY="libkdenetwork/
	libkpgp/
	libkdepim/"
KMEXTRA="doc/kleopatra
	doc/kwatchgnupg"
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE certificate manager gui."
IUSE=""

DEPEND="=kde-base/libkdenetwork-${PV}:${SLOT}
	>=app-crypt/gpgme-1.1.2-r1
	|| ( >=app-crypt/gnupg-2.0.1-r1 <app-crypt/gnupg-1.9 )"
	# We use GnuPG 1.4.x for OpenPGP and 1.9 (via gpgme) for s/mime as upstream advises.

RDEPEND="${DEPEND}"

src_compile() {
	myconf="--with-gpg=/usr/bin/gpg"
	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst
	elog "For X.509 CRL and OCSP support, install app-crypt/dirmngr, please."
}
