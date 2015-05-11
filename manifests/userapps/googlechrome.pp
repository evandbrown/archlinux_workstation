# == Class: archlinux_workstation::userapps::googlechrome
#
# Install chromium
#
# === Actions:
#   - Install google-chrome
#
class archlinux_workstation::userapps::googlechrome {

  package {'chromium':
    ensure  => present,
  }
}
