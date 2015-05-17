# == Class: archlinux_workstation::userapps::firefox
#
# Install firefox
#
# === Actions:
#   - Install firefox
#
class archlinux_workstation::userapps::clementine{

  package {'clementine':
    ensure  => present,
  }

}
