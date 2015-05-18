class archlinux_workstation::userapps::dropbox {
  archlinux_workstation::aur { 'dropbox':
    ensure => present,
  }
}
