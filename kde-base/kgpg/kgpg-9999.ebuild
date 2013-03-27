# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE gpg keyring manager"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	app-crypt/gnupg
	|| ( app-crypt/pinentry[qt3] app-crypt/pinentry[gtk] )"