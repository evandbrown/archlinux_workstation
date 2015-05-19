# == Class: archlinux_workstation
#
# Main class for archlinux_workstation.
#
# Assuming my configuration's defaults are suitable for you,
# declare this class, passing it the appropriate parameters.
#
# See README.markdown for advanced usage.
#
# This class declares other classes in this module with
# appropriate parameters. For documentation on specific actions
# taken, see the other classes.
#
# It also uses the following classes outside of this module:
#
# * [saz/sudo](https://github.com/saz/puppet-sudo) to manage sudoers
#   and sudoers.d entries for root and your user
# * [saz/ssh](http://forge.puppetlabs.com/saz/ssh) to configure sshd
#   server; access limited to $username only, pubkey/RSA
#
# === Parameters
#
# * __username__ - (string) Your login username. Used to create
#   your account, add you to certain groups, etc. Default: undef.
#   If left undefined, this module will not do anything to users
#   or groups, or anything that is user-specific.
#
# * __userhome__ - Path to $username's home directory. Used for
#   classes that put files in the user's home directory, and to
#   create SSH keys for the user. Default: "/home/${username}.
#   If set to undef, this module will not act on anything within
#   the user's home directory.
#
# * __groups__ - Array of strings of group names to add user to.
#  Not required.
#
# * __gui__ - Install a graphical/desktop environment. Currently
#   accepted values are "kde", "i3" or undef. Pull requests welcome for others.
#   X will be installed either way.
#
# * __userapps__ - (boolean) if true, install the user apps specified
#   in the ``::userapp::`` classes. (Default: true)
#
class archlinux_workstation (
  $username        = undef,
  $userhome       = "/home/${username}",
  $groups	   = undef,
  $gui             = 'i3',
  $userapps        = true,
  $dotfiles        = undef,
) inherits archlinux_workstation::params {

  # make sure we're on arch, otherwise fail
  if $::osfamily != 'Archlinux' {
    fail("${::operatingsystem} not supported")
  }

  # validate parameters here
  validate_absolute_path($userhome)
  if $gui != undef {
    validate_re($gui, '^(kde|i3)$')
  }
  validate_bool($userapps)

  # saz/sudo; this purges the current config
  class {'sudo': }

  sudo::conf {'defaults-env_keep':
    priority => 0,
    content  => 'Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET QTDIR KDEDIR XDG_SESSION_COOKIE"'
  }

  sudo::conf {"${username}-all":
    priority => 10,
    content  => "${username} ALL=(ALL) ALL",
  }

  class {'archlinux_workstation::base_packages': }
  class {'archlinux_workstation::dkms': }
  class {'archlinux_workstation::aura': }
  class {'archlinux_workstation::dev': }

  # This should be teased out into a hardware-specific module
  class {'archlinux_workstation::lenovox1gen3': }

  # internal $userhome is undef if $username is undef
  if ! $username {
    $userhome = undef
  } else {
    archlinux_workstation::user { $username:
      username => $username,
      homedir  => $userhome,
      groups   => $groups,
      dotfiles => $dotfiles,
    }
  }

  if $gui == 'kde' {
    class {'archlinux_workstation::kde': }
    class {'archlinux_workstation::kdm': }
  }
  elsif $gui == 'i3' {
    class {'archlinux_workstation::i3':
      username => $username,
      userhome => $userhome,
    }
  }

  if $::virtual == 'virtualbox' {
    class {'archlinux_workstation::vboxguest': }
  }

  class {'archlinux_workstation::networkmanager':
    gui => $gui,
  }

  class {'archlinux_workstation::alsa': }

  class {'archlinux_workstation::xorg': }

  # user apps
  if $userapps == true {
    class {'archlinux_workstation::userapps':
      username => $username,
      userhome => $userhome,
    }
  }
}
