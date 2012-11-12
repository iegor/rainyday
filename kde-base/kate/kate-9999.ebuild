# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-3.5.10.ebuild,v 1.7 2009/07/12 09:33:36 armin76 Exp $

EAPI=2
KMNAME=kdebase
KDE_DOWNLOAD_SOURCE="git"
KMEXTRA="doc/kwrite"
inherit kde-meta eutils
DESCRIPTION="[GIT] Kate is an MDI texteditor."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"