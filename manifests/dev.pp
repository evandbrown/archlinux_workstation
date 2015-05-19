class archlinux_workstation::dev {
  archlinux_workstation::aur { 'powerline-fonts':
    ensure => present,
  }
}
