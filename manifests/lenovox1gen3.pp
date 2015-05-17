# Class: archlinux_workstation::base_packages
#
# Collection of base packages that we want installed on the Lenovo
# X1 Carbon, 34d Generation
#
#
class archlinux_workstation::lenovox1gen3 {
  package {'xf86-video-intel': ensure => present, }
  package {'xf86-input-synaptics': ensure => present, }
  package {'gpointing-device-settings': ensure => present,}
  package {'tlp': ensure => present, }
  package {'network-manager-applet': ensure => present, }

archlinux_workstation::aur { 'asoundconf':
    ensure => present,
  }
}
