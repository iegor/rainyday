# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="This project is set environment, which is using compiz-fusion as wm"
HOMEPAGE="https://github.com/iegor/coldfusion"
SRC_URI=""

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="docky gnome-do cairo-dock extras gnome-systools +emerald"
FEATURES="sandbox collision-protect strict"

CATEGORY="x11-wm"

MERGE_TYPE="binary"

DEPEND="x11-wm/compiz-fusion
docky? ( gnome-extra/docky )
x11-wm/emerald
gnome-extra/gnome-do
gnome-extra/gnome-system-monitor
app-admin/gnome-system-tools"
RDEPEND="${DEPEND}"

CF_VERSION=0.0.1

# Creating my own path variable containing path to current version of bumblebee
# and modifying S path
MY_P=coldfusion-${CF_VERSION}
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	ebegin "Package setup"
	eend 0
}

src_unpack() {
	mkdir ${S}

	cp ${FILES_DIR}/start-cf.sh ${S}/
	cp ${FILES_DIR}/cold-fusion ${S}/
	cp ${FILES_DIR}/coldfusion.desktop ${S}/
}

src_install() {
	# awful cheat to detemine current user (in who's dir will configs be dropped)
	WM_SUDO_USER=$(env|grep SUDO_USER|cut -f2 -d=)

	dodir /home/${WM_SUDO_USER}/.coldfusion

	exeinto /usr/local/bin
	doexe ${S}/start-cf.sh

	exeinto /usr/bin
	doexe ${S}/cold-fusion

	insinto /usr/share/xsessions
	doins ${S}/coldfusion.desktop
}
