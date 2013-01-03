# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.5.10-r1.ebuild,v 1.8 2009/08/25 14:57:54 jer Exp $

EAPI=2
KMNAME=kdepim
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] library common to many KDE network apps"
IUSE=""

DEPEND=">=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"
