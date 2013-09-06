# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE gpg keyring manager"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="${RDEPEND}
	app-crypt/gnupg
	|| ( app-crypt/pinentry[qt3] app-crypt/pinentry[gtk] )"
