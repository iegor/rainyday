# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.17.5.ebuild,v 1.1 2013/11/13 22:29:07 tommy Exp $

EAPI=5

inherit enlightenment

DESCRIPTION="Enlightenment DR17 window manager"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0.17/${PV/_pre2}"

# The @ is just an anchor to expand from
__EVRY_MODS=""
__CONF_MODS="
	+@applications +@dialogs +@display +@edgebindings
	+@interaction +@intl +@keybindings +@menus
	+@paths +@performance +@randr +@shelves +@theme
	+@window-manipulation +@window-remembers"
__NORM_MODS="
	@access +@backlight +@battery +@clock +@comp +@connman +@cpufreq +@dropshadow
	+@everything +@fileman +@fileman-opinfo +@gadman +@ibar +@ibox +@illume2
	+@mixer	+@msgbus +@notification +@pager +@quickaccess @shot +@start
	+@syscon +@systray +@tasks +@temperature +@tiling +@winlist +@wizard +@xkbswitch"
IUSE_E_MODULES="
	${__CONF_MODS//@/enlightenment_modules_conf-}
	${__NORM_MODS//@/enlightenment_modules_}"

IUSE="emotion pam spell static-libs +udev ukit ${IUSE_E_MODULES}"

RDEPEND="
	pam? ( sys-libs/pam )
	>=dev-libs/eet-1.7.9
	>=dev-libs/efreet-1.7.9
	>=dev-libs/eio-1.7.9
	>=dev-libs/eina-1.7.9[mempool-chained-pool]
	|| ( >=dev-libs/ecore-1.7.9[X,evas,inotify] >=dev-libs/ecore-1.7.9[xcb,evas,inotify] )
	>=media-libs/edje-1.7.9
	>=dev-libs/e_dbus-1.7.9[libnotify,udev?]
	ukit? ( >=dev-libs/e_dbus-1.7.9[udev] )
	enlightenment_modules_connman? ( >=dev-libs/e_dbus-1.7.9[connman] )
	enlightenment_modules_shot? ( >=dev-libs/ecore-1.7.9[curl] )
	|| ( >=media-libs/evas-1.7.9[eet,X,jpeg,png] >=media-libs/evas-1.7.9[eet,xcb,jpeg,png] )
	>=dev-libs/eeze-1.7.9
	emotion? ( >=media-libs/emotion-1.7.9 )
	x11-libs/xcb-util-keysyms"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/quickstart.diff
	enlightenment_src_prepare
}

src_configure() {
	E_ECONF+=(
		--disable-install-sysactions
		--disable-elementary
		$(use_enable doc)
		--disable-device-hal
		$(use_enable emotion)
		--disable-mount-hal
		$(use_enable nls)
		$(use_enable pam)
		--enable-device-udev
		$(use_enable udev mount-eeze)
		$(use_enable ukit mount-udisks)
		--disable-physics
	)
	local u c
	for u in ${IUSE_E_MODULES} ; do
		u=${u#+}
		c=${u#enlightenment_modules_}
		E_ECONF+=( $(use_enable ${u} ${c}) )
	done
	enlightenment_src_configure
}

src_install() {
	enlightenment_src_install
	insinto /etc/enlightenment
	newins "${FILESDIR}"/gentoo-sysactions.conf sysactions.conf
}
