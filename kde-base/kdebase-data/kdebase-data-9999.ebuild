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

RDEPEND="
!kde-base/kdebase-l10n !kde-base/kdebase-applnk !kde-base/kdebase-pics" # replaced these three ebuilds
