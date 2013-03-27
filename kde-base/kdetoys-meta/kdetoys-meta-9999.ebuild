# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdetoys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE=""

RDEPEND="
=kde-base/amor-${PV}:${SLOT}
=kde-base/eyesapplet-${PV}:${SLOT}
=kde-base/fifteenapplet-${PV}:${SLOT}
=kde-base/kmoon-${PV}:${SLOT}
=kde-base/kodo-${PV}:${SLOT}
=kde-base/kteatime-${PV}:${SLOT}
=kde-base/ktux-${PV}:${SLOT}
=kde-base/kweather-${PV}:${SLOT}
=kde-base/kworldclock-${PV}:${SLOT}
"
