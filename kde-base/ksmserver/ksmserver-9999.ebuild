# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMEXTRACTONLY="kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KMNODOCS=true
inherit kde-meta eutils
DESCRIPTION="[GIT] The reliable KDE session manager that talks the standard X11R6"
IUSE="kdehiddenvisibility dbus"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# Re-add those patches later on. And put them in the patchset tarball.
#EPATCH_EXCLUDE="ksmserver-3.5.8-ksmserver_suspend.diff
#				ksmserver-3.5.8-suspend_configure.diff"
