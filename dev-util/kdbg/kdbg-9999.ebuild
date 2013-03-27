# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
KMMODULE=kdbg
ARTS_REQUIRED="never"
inherit eutils kde
SLOT="3.5"
LICENSE="GPL-2"
DESCRIPTION="[GIT] A Graphical Debugger Interface to gdb."
HOMEPAGE="http://www.kdbg.org/"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-devel/gdb-5.0"

need-kde 9999
