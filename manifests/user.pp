# == Define: archlinux_workstation::user
#
# Manage a single real user on the system (i.e. a login user).
#
# Per the Arch standard, a group with the same name as the user will
# be created, and will be the user's primary group.
#
# === Parameters
#
# * __username__ - (string) The user's username.
#   Defaults to the resource title.
#
# * __realname__ - (string) The user's real name, to be used
#   in the passwd comment/GECOS field.
#
# * __homedir__ - (string) Path to $username's home directory.
#   Will be created if it does not exist.
#
# * __shell__ - (string) the user's login shell.
#   Default: '/bin/bash'
#
# * __groups__ - (array) list of supplementary groups that
#   this user should be a member of. Default: undef.
#
# === Actions
#
# * ensure the user exists, via the built-in [User](http://docs.puppetlabs.com/references/latest/type.html#user) type
# * ensure that a group with the same name as the username exists,
#   via the built-in [Group](http://docs.puppetlabs.com/references/latest/type.html#group) type.
#
define archlinux_workstation::user (
  $username        = $title,
  $realname        = $title,
  $homedir         = "/home/${username}",
  $shell           = '/bin/bash',
  $groups          = undef,
  $dotfiles	   = undef
) {

  user { $username:
    ensure     => present,
    name       => $username,
    comment    => $realname,
    gid        => $username,
    home       => $homedir,
    managehome => true,
    shell      => $shell,
  }

  if $groups {
    User[$username] {
      groups  => $groups,
      require => Group[$username],
    }
  } else {
    User[$username] {
      require => Group[$username],
    }
  }

  group { $username:
    ensure => present,
    name   => $username,
    system => false,
  }

  if $dotfiles {
    exec { "${username}-dotfiles":
      cwd	  => $homedir,
      path        => '/usr/bin',
      environment => "HOME=${homedir}",
      command	  => "mkdir .ssh ; rm .bash_profile ; rm .bashrc ; git clone ${dotfiles} && mv dotfiles .dotfiles && cd .dotfiles && ./install.sh",
      creates     => "${homedir}/.dotfiles/install.sh",
      user	  => $username,
      require	  => Package['git'],
    }
  }
}
