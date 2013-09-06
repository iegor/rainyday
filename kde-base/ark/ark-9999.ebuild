# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta
DESCRIPTION="[GIT] KDE Archiving tool"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

pkg_postinst(){
	kde_pkg_postinst
	elog "You may want to install app-arch/lha, app-arch/p7zip, app-arch/rar, app-arch/zip"
	elog "or app-arch/zoo for support of these archive types."
}
