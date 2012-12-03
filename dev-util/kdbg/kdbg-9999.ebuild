# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.2.0.ebuild,v 1.2 2009/10/05 02:41:45 dirtyepic Exp $

EAPI=2
KMNAME=kdesdk
KMMODULE=kdbg
ARTS_REQUIRED="never"
KDE_DOWNLOAD_SOURCE="git"
inherit eutils kde
LICENSE="GPL-2"
DESCRIPTION="[GIT] A Graphical Debugger Interface to gdb."
HOMEPAGE="http://www.kdbg.org/"
# SRC_URI="mirror://sourceforge/kdbg/kdbg-2.2.0.tar.gz"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-devel/gdb-5.0"

need-kde 9999
