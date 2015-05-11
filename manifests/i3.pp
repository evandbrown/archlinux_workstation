# == Class: archlinux_workstation::i3
#
# Perform a full installation of [i3](https://wiki.archlinux.org/index.php/i3) via the "i3" package group.
#
# === Actions:
#   - install "i3" package group
#
<<<<<<< HEAD
class archlinux_workstation::i3 (
  $username,
  $userhome,
)
{

  package {'i3':
    ensure => present,
  }

  package {'dmenu':
    ensure => present,
  }

  package {'terminator':
    ensure => present,
  } 

  file {"${userhome}/.xinitrc":
    ensure => present,
    owner  => "${username}", 
    group  => "${username}",
    mode   => '0755',
    source => 'puppet:///modules/archlinux_workstation/xinitrc',
  }
}
