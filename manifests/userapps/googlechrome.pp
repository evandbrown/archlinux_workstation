# == Class: archlinux_workstation::userapps::googlechrome
#
# Install proprietary google-chrome package and ttf-google-fonts-git from archlinuxfr repository.
#
# === Actions:
#   - Install google-chrome
#
class archlinux_workstation::userapps::googlechrome {

  package {'chromium':
    ensure  => present,
  }
}
