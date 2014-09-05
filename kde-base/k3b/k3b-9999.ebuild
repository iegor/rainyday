EAPI=2
KMNAME=kdeutils
KMEXTRACTONLY="k3b/FAQ k3b/KNOWNBUGS k3b/PERMISSIONS"
inherit kde-meta eutils
DESCRIPTION="[GIT] K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
# SRC_URI="mirror://sourceforge/k3b/${P/_}.tar.bz2"
# LICENSE="GPL-2"
# SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa css dvd dvdr encode emovix ffmpeg flac hal mp3 musicbrainz
	sndfile vcd vorbis"

COMMON_DEPEND="!<app-cdr/k3b-1.0.5-r5
	media-libs/libsamplerate
	media-libs/taglib
	media-sound/cdparanoia
	alsa? ( media-libs/alsa-lib )
	dvd? ( media-libs/libdvdread )
	encode? ( media-sound/lame )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	flac? ( media-libs/flac[cxx] )
	hal? ( sys-apps/hal )
	mp3? ( media-libs/libmad )
	musicbrainz? ( media-libs/musicbrainz:1 )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${COMMON_DEPEND}
	app-cdr/cdrdao
	media-sound/normalize
	virtual/cdrtools
	dvdr? ( >=app-cdr/dvd+rw-tools-7 )
	css? ( media-libs/libdvdcss )
	encode? ( media-sound/sox
		media-video/transcode[dvd] )
	emovix? ( media-video/emovix )
	vcd? ( media-video/vcdimager )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

# I18N="${PN}-i18n-${PV}"

# Supported languages and translated documentation
LANGS="af ar bg br bs ca cs cy da de el en_GB es et eu fa fi fr ga gl he hi hu is it
	ja ka lt mk ms nb nds nl nn pa pl pt pt_BR ru rw se sk sr sr@Latn sv ta tr uk
	uz zh_CN zh_TW"
for X in ${LANGS}; do
	# SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/k3b/${I18N}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

# src_unpack() {
	# kde-meta_src_unpack

	# if [ -d "${WORKDIR}/${I18N}" ]; then
	# 	cd "${WORKDIR}/${I18N}"
	# 	for X in ${LANGS}; do
	# 		use linguas_${X} || rm -rf "${X}"
	# 	done
	# 	rm -f configure
	# fi
	# rm -f "${S}"/configure
# }

src_configure() {
	KDE_S="${S}"
	local myconf="--with-external-libsamplerate
		--without-resmgr
		--without-cdrecord-suid-root
		--without-k3bsetup
		--disable-dependency-tracking
		$(use_enable debug)
		$(use_with hal)
		$(use_with encode lame)
		$(use_with ffmpeg)
		$(use_with flac)
		$(use_with vorbis oggvorbis)
		$(use_with sndfile)
		$(use_with mp3 libmad)
		--without-musepack
		$(use_with musicbrainz)
		$(use_with dvd libdvdread)
		$(use_with alsa)"

	# Build process of K3b
	kde-meta_src_configure

	# Build process of K3b-i18n
	# if [[ -d "${WORKDIR}/${I18N}" ]]; then
	# 	myconf="--with-qt-dir=${QTDIR}
	# 		--with-qt-libraries=${QTDIR}/$(get_libdir)
	# 		--disable-dependency-tracking
	# 		--without-arts
	# 		$(use_enable debug)"
	# 	KDE_S="${WORKDIR}/${I18N}"
	# 	kde_src_configure
	# fi
}

src_compile() {
	kde-meta_src_compile

	# if [[ -d "${WORKDIR}/${I18N}" ]]; then
	# 	KDE_S="${WORKDIR}/${I18N}"
	# 	kde_src_compile
	# fi
}

src_install() {
	KDE_S="${S}"
	kde-meta_src_install
	dodoc ${PN}/FAQ || die "dodoc failed: FAQ"
	dodoc ${PN}/KNOWNBUGS || die "dodoc failed: KNOWNBUGS"
	dodoc ${PN}/PERMISSIONS || die "dodoc failed: PERMISSIONS"

	# if [[ -d "${WORKDIR}/${I18N}" ]]; then
	# 	KDE_S="${WORKDIR}/${I18N}"
	# 	kde_src_install
	# fi
}

pkg_postinst() {
	echo
	elog "We don't install k3bsetup anymore because Gentoo doesn't need it."
	elog "If you get warnings on start-up, uncheck the \"Check system"
	elog "configuration\" option in the \"Misc\" settings window."
	echo

	local group=cdrom
	use kernel_linux || group=operator
	elog "Make sure you have proper read/write permissions on the cdrom device(s)."
	elog "Usually, it is sufficient to be in the ${group} group."
	echo
}
