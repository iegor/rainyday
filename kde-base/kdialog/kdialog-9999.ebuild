# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.5.10.ebuild,v 1.7 2009/07/12 09:28:52 armin76 Exp $

EAPI=2
KMNAME=kdebase
KMEXTRA="kdeeject"
KMNODOCS=true
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

# Uses cdcontrol on FreeBSD
RDEPEND="kernel_linux? ( || ( >=sys-block/eject-2.1.5 sys-block/unieject ) ) "
