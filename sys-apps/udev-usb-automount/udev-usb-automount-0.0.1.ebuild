# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit eutils

DESCRIPTION="auto mount scripts to mount usb drives."
HOMEPAGE=""

LICENSE="fl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

FEATURES="sandbox collision-protect strict"

RDEPEND="sys-fs/udev
kde? ( >=kde-base/kdelibs-3.5.10-r9999 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

# src_prepare()
# {
# 	# make error with $S go away.
# 	mkdir ${S}
# }

src_install()
{
	exeinto /usr/local/bin
	newexe ${FILESDIR}/mount_usb.sh	mount_usb.sh
	newexe ${FILESDIR}/umount_usb.sh umount_usb.sh

	insinto /etc/udev/rules.d
	doins ${FILESDIR}/10-usb-mount.rules
	doins ${FILESDIR}/11-usb-N900-mount.rules

# 	die "debug"
}

pkg_postinst()
{
	# reload udev rules
	ebegin "Reload udev rules"
	/sbin/udevadm control --reload-rules
	eend 0

	einfo "udev rules was reloaded. Please try now to insert your usb device."	
	einfo "Please use only konqueror mount dialog to mount your drives."	
	einfo "N900 mount option added."
	einfo "	Please do not mount N900 until have chosen \"External drive\" option on N900 device."
}