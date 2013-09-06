# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-3.5.10.ebuild,v 1.8 2009/10/13 17:03:04 ssuominen Exp $
EAPI="2"
KMNAME=kdeutils

inherit kde-meta eutils

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	app-crypt/gnupg
	|| ( app-crypt/pinentry[qt3] app-crypt/pinentry[gtk] )"

PATCHES=( "${FILESDIR}/${KMNAME}_${PN}-r995144.patch" )
