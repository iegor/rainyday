# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="
=kde-base/atlantikdesigner-${PV}:${SLOT}
=kde-base/knewsticker-scripts-${PV}:${SLOT}
=kde-base/ksig-${PV}:${SLOT}
=kde-base/kaddressbook-plugins-${PV}:${SLOT}
=kde-base/kate-plugins-${PV}:${SLOT}
=kde-base/kicker-applets-${PV}:${SLOT}
=kde-base/kdeaddons-kfile-plugins-${PV}:${SLOT}
=kde-base/konq-plugins-${PV}:${SLOT}
=kde-base/konqueror-akregator-${PV}:${SLOT}
=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}
=kde-base/renamedlg-audio-${PV}:${SLOT}
=kde-base/renamedlg-images-${PV}:${SLOT}"
