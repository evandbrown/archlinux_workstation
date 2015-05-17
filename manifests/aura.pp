class archlinux_workstation::aura(
) {
  package { 'curl':
    ensure => 'present',
  }
  package { 'bc':
    ensure => 'present',
  }

  exec { 'pacman-base-devel':
    command   => '/usr/bin/pacman -S base-devel --needed --noconfirm',
    unless    => '/usr/bin/pacman -Qk aura-bin',
    require   => [Package['curl'], Package['bc']],
    logoutput => 'on_failure',
  }

  # make sure yaourt install is always correct via pacman -Qk
  exec { 'pacman::aura-install':
    command => '/usr/bin/sudo -u nobody sh -c "/bin/curl -L -o /tmp/aura.tar.gz https://aur.archlinux.org/packages/au/aura-bin/aura-bin.tar.gz && /usr/bin/tar -xvf aura.tar.gz && cd aura-bin && /usr/bin/makepkg" && /usr/bin/pacman -U aura-bin/aura-bin-*.tar.xz --noconfirm',
    cwd       => '/tmp',
    unless    => '/usr/bin/pacman -Qk aura-bin',
    require   => Exec['pacman-base-devel'],
    logoutput => 'on_failure',
  }
}
