EAPI=2
KMNAME=kdebase
inherit kde-meta
DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
IUSE="javascript kde"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
HOMEPAGE="http://www.krusader.org/"

DEPEND="
	kde? (
		kde-base/libkonq:3.5
		kde-base/kdebase-kioslaves:3.5
	)
	javascript? ( kde-base/kjsembed:3.5 )"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde-meta_pkg_postinst
	echo
	elog "For information about additional features and tools such as remote file access, packers,"
	elog "etc. you may want to use, see \"external-tools\" in /usr/share/doc/${PF}."
	echo
}

#src_unpack() {
#	kde-meta_src_unpack
#	# Don't use kde_src_unpack or the new admindir updating code
#	# will reset admindir before the configure.in.bot change is fixed.
#	unpack ${A}
#
#	# Stupid thing to do, but upstream did it
#	mv "${S}/admin/configure.in.bot.end" "${S}/configure.in.bot"
#
#	rm -rf "${S}/admin" "${S}/configure"
#	ln -s "${WORKDIR}/admin" "${S}/admin"
#	epatch "${FILESDIR}/${PV}-icon-overlay.patch"
#}

src_compile() {
	local myconf="$(use_with kde konqueror) $(use_with javascript) --without-kiotar"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install
	dodoc "${FILESDIR}/external-tools" || die "Installing docs failed."
}
