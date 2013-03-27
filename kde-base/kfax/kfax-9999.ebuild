# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE G3/G4 fax viewer"
IUSE=""

DEPEND="=kde-base/kviewshell-${PV}:${SLOT}"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"
KMCOMPILEONLY="kviewshell"
