class archlinux_workstation::dev {

  # Powerline fonts
  archlinux_workstation::aur { 'powerline-fonts':
    ensure => present,
  }

  # Docker
  package {'docker': ensure => present, }
  service {'docker':
    enable => true,
    ensure => running,
    require => Package['docker'],
  }

  # Golang
  package {'go': ensure => present, }
}
