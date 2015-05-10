# == Class: archlinux_workstation::i3
#
# Perform a full installation of [i3](https://wiki.archlinux.org/index.php/i3) via the "i3" package group.
#
# === Actions:
#   - install "i3" package group
#
# === Parameters
#
# * __username__ - (string) User to install xinitrc for
#
# * __userhome__ - Path to $username's home directory. Default: "/home/${username}.
#
class archlinux_workstation::i3 (
  $username = undef,
  $userhome = undef,
) {
  package {'i3':
    ensure => present,
  }
  
  package {'dmenu':
    ensure => present,
  }
  
  package {'xterm':
    ensure => present,
  }
  
  # Create an .xinitrc
  file {'${userhome}/.xinitrc':
    ensure => present,
    owner  => '{$username}',
    group  => '{$username}',
    mode   => '0755',
    source => 'puppet:///modules/archlinux_workstation/xinitrc',
  }
}
