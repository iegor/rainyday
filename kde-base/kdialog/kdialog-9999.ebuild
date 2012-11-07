# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.5.10.ebuild,v 1.7 2009/07/12 09:28:52 armin76 Exp $
EAPI="1"
KMNAME=kdebase
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="[GIT] KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KDE_DOWNLOAD_SOURCE="git"

# Uses cdcontrol on FreeBSD
RDEPEND="kernel_linux? ( || ( >=sys-block/eject-2.1.5 sys-block/unieject ) ) "

KMEXTRA="kdeeject"
KMNODOCS=true