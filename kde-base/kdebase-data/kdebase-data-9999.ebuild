# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
RESTRICT="binchecks strip"
KMNAME=kdebase
KMNOMODULE=true
KMEXTRA="l10n pics applnk"
inherit kde-meta
DESCRIPTION="[GIT] Icons, localization data and .desktop files from kdebase. Includes l10n, pics and applnk subdirs."
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="
!=kde-base/kdebase-l10n-${PV}:${SLOT}
!=kde-base/kdebase-applnk-${PV}:${SLOT}
!=kde-base/kdebase-pics-${PV}:${SLOT}" # replaced these three ebuilds
