# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] library common to many KDE network apps"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=">=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"
