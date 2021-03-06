# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit desktop git-r3 python-any-r1 xdg

DESCRIPTION="A GUI frontend for ffmpeg livestreaming"
HOMEPAGE="https://github.com/TheSamsai/Castawesome"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="${PYTHON_DEPENDS}
	x11-libs/gtk+:3
	dev-python/pygobject:2
	virtual/ffmpeg
	"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-Makefile.patch" )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	sed -i 's#cp castawesome.py#install -Dm 755 castawesome.py#' Makefile
	sed -i 's#/usr/local#$(DESTDIR)/usr#g' Makefile
	sed -i 's#/usr/local#/usr#' castawesome.py
	sed -i 's#/usr/local#/usr#' uninstall_castawesome.sh
	sed -i 's#Gnome;Internet#Network;AudioVideo#' Castawesome.desktop
	sed -i 's#/home/sami/Ohjelmointi/Projektit/castawesome/IconCA.png#castawesome.png#' Castawesome.desktop
	default
}

src_install() {
	default
	rm "${ED}/usr/bin/uninstall_${PN}" || die
}
