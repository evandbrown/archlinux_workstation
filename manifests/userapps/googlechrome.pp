# == Class: archlinux_workstation::userapps::googlechrome
#
# Install chromium
#
# === Actions:
#   - Install google-chrome
#
class archlinux_workstation::userapps::googlechrome {
  archlinux_workstation::aur { 'google-chrome':
    ensure => present,
  }
}
