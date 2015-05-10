# == Class: archlinux_workstation::i3
#
# Perform a full installation of [i3](https://wiki.archlinux.org/index.php/i3) via the "i3" package group.
#
# === Actions:
#   - install "i3" package group
#
class archlinux_workstation::i3 {
  package {'i3':
    ensure => present,
  }
  
  package {'dmenu':
    ensure => present,
  }
}
