define archlinux_workstation::aur(
  $ensure = 'present',
) {

  case $ensure {
    'present': {
      exec { "archlinux_workstation::aur::install::${name}":
        require   => Class[archlinux_workstation::aura],
        command   => "/usr/bin/aura -A --noconfirm ${name}",
        unless    => "/usr/bin/aura -Qk ${name}",
        logoutput => 'on_failure',
        timeout   => 1800,
      }
    }
    'absent': {
      exec { "archlinux_workstation::aur::remove::${name}":
        require   => Class[archlinux_workstation::aura],
        command   => "/usr/bin/aura -Rs ${name} --noconfirm",
        onlyif    => "/usr/bin/aura -Qi ${name}",
        logoutput => 'on_failure',
      }
    }
    default: {
      fail("Archlinux_Workstation::Aur[${name}] ensure parameter must be either 'present' or 'absent'")
    }

  }
}
