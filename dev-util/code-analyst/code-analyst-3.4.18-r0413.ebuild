# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="AMD's front end GUI for Oprofile."
HOMEPAGE="http://developer.amd.com/tools/heterogeneous-computing/amd-codeanalyst-performance-analyzer/amd-codeanalyst-performance-analyzer-for-linux/"
# SRC_URI="http://developer.amd.com/wordpress/media/files/CodeAnalyst-3_4_18_0413-Public.tar.gz"
SRC_URI="http://developer.amd.com/wordpress/media/files/download.php?f=Q29kZUFuYWx5c3QtM180XzE4XzA0MTMtUHVibGljLnRhci5neg==
-> CodeAnalyst-3_4_18_0413-Public.tar"

inherit eutils qt3

LICENSE="GPL-v2"
SLOT="3"
KEYWORDS="~x86 ~amd64"
IUSE=""

FEATURES="sandbox"

DEPEND="
>=dev-util/oprofile-0.9.6
"
RDEPEND="
${DEPEND}
"

S="${WORKDIR}/CodeAnalyst-3_4_18_0413-Public"

src_prepare() {
	einfo "***********************************************************"
	einfo "*                 C O D E A N A L Y S T                   *"
	einfo "*                                                         *"
	einfo "*                       FOR LINUX                         *"
	einfo "*                                                         *"
	einfo "*   - Please see README file before installation.         *"
	einfo "*                                                         *"
	einfo "*   - Please refer to INSTALLATION file for building      *"
	einfo "*     and installation instruction.                       *"              
	einfo "*                                                         *"
	einfo "*   - In case of error, please run \"careport.sh\" and      *"
	einfo "*     submit file \"careport.txt\" to codeanalyst team.     *"
	einfo "*                                                         *"
	einfo "***********************************************************"

	# Set release string
	ebegin "checking release"
	if test -d "src/careport.txt/events/internal" ; then 
#		sed "s/CARELEASEX/internal/g" < configure.in > configure.ac
		echo "internal"
	else
#		sed "s/CARELEASEX/public/g" < configure.in > configure.ac
		echo "public"
	fi
	eend ${?}
	
	# Check space in path. This can fail libtool.
	ebegin "checking current path"
	$(pwd | grep ' ' > /dev/null)
	if test $? = 0
	then
		echo "WARNING: The current path :"
		echo ""
		echo "$(pwd)" 
		echo ""
		echo "might cause problem with libtool due to the space in"
		echo "directory name. Please remove any spaces in the the"
		echo "path to current directory."
		exit 1
	else
		echo "$(pwd)"
	fi
	eend ${?}

	# Check the necessary tools
	ebegin "checking aclocal"
	ACLOCAL="$(which aclocal 2> /dev/null)"
	eend ${?}

	ebegin "checking autoheader"
	AUTOHEADER="$(which autoheader 2> /dev/null)"
	eend ${?}

	ebegin "checking libtoolize"
	LIBTOOLIZE="$(which libtoolize 2> /dev/null)"
	eend ${?}

	ebegin "checking andutomake"
	AUTOMAKE="$(which automake 2> /dev/null)"
	eend ${?}

	ebegin "checking autoconf"
	AUTOCONF="$(which autoconf 2> /dev/null)"
	eend ${?}

	rm -rf autom4te.cache/*
	${ACLOCAL} -I m4
	${AUTOHEADER}
	${LIBTOOLIZE} --automake --force
	${AUTOMAKE} --add-missing
	${AUTOCONF}
}

src_configure() {
	#--with-qt-dir           where the root of Qt is installed
	#--with-qt-includes      where the Qt includes are.
	#--with-qt-libraries     where the Qt library is installed.

	# cd ${S}
	econf "--with-qt-dir=${QTDIR}"
	#\
	#	--with-qt-libraries=${QTDIR}/$(get_libdir) \
	#	--with-qt-includes=${QTDIR}/include"
}

# src_compile() {
# }
