# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-3.5.10.ebuild,v 1.8 2009/09/11 12:06:19 tampakrap Exp $

EAPI=2
KMNAME=kdeutils
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta
DESCRIPTION="KDE Archiving tool"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

pkg_postinst(){
	kde_pkg_postinst
	elog "You may want to install app-arch/lha, app-arch/p7zip, app-arch/rar, app-arch/zip"
	elog "or app-arch/zoo for support of these archive types."
}
