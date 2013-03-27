# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
IUSE="gphoto2 scanner povray imlib"

RDEPEND="
gphoto2? ( =kde-base/kamera-${PV}:${SLOT} )
=kde-base/kcoloredit-${PV}:${SLOT}
=kde-base/kdegraphics-kfile-plugins-${PV}:${SLOT}
=kde-base/kdvi-${PV}:${SLOT}
=kde-base/kfax-${PV}:${SLOT}
=kde-base/kgamma-${PV}:${SLOT}
=kde-base/kghostview-${PV}:${SLOT}
=kde-base/kiconedit-${PV}:${SLOT}
=kde-base/kolourpaint-${PV}:${SLOT}
scanner? ( =kde-base/kooka-${PV}:${SLOT}
						=kde-base/libkscan-${PV}:${SLOT} )
povray? ( =kde-base/kpovmodeler-${PV}:${SLOT} )
=kde-base/kruler-${PV}:${SLOT}
=kde-base/ksnapshot-${PV}:${SLOT}
=kde-base/ksvg-${PV}:${SLOT}
imlib? ( =kde-base/kuickshow-${PV}:${SLOT} )
=kde-base/kview-${PV}:${SLOT}
=kde-base/kviewshell-${PV}:${SLOT}
"
