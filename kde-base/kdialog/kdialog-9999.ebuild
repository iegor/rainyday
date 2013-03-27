# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMEXTRA="kdeeject"
KMNODOCS=true
inherit kde-meta eutils
DESCRIPTION="[GIT] KDialog can be used to show nice dialog boxes from shell scripts"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# Uses cdcontrol on FreeBSD
RDEPEND="kernel_linux? ( || ( >=sys-apps/util-linux-2.22.2 ) ) "
