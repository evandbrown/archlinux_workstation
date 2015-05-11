# == Class: archlinux_workstation::i3
#
# Perform a full installation of [VirtualBox Guest Utils](https://wiki.archlinux.org/index.php/virtualbox-guest-utils).
#
# === Actions:
#   - install "virtualbox-guest-utils" package group
#
class archlinux_workstation::vboxguest (
  $username,
  $userhome,
)
{

  package {'virtualbox-guest-utils':
    ensure => present,
  }

  service {'vboxservice':
    ensure => running,
    enable => true,
  }

  exec {'exec-vbox-additions':
    user        => "${username}", 
    command     => "sed -i '2i/usr/bin/VBoxClient-all' ${userhome}/.xinitrc",
    path	=> "/usr/bin",
    require     => Class['i3'],
  }

}
