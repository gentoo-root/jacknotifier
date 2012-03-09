# media-sound/jacknotifier/jacknotifier-9999.ebuild
EAPI=3

inherit git-2

DESCRIPTION="Headphones Jack Notification Daemon"
HOMEPAGE="https://github.com/gentoo-root/jacknotifier"
EGIT_REPO_URI="git://github.com/gentoo-root/jacknotifier.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/dbus
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README* ChangeLog
}
