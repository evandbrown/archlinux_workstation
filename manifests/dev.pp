class archlinux_workstation::dev {

  # Docker
  package {'docker': ensure => present, }
  service {'docker':
    enable => true,
    ensure => running,
    require => Package['docker'],
  }

  # Golang
  package {'go': ensure => present, }

  # pip, virtualenv, and virtualenv wrapper
  package {['python-pip', 'python-virtualenv', 'python-virtualenvwrapper']: ensure => present, }

}
