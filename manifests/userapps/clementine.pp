# == Class: archlinux_workstation::userapps::firefox
#
# Install firefox
#
# === Actions:
#   - Install firefox
#
class archlinux_workstation::userapps::clementine{

$clementine_packages = [
  'gstreamer0.10',
  'gstreamer0.10-bad',
  'gstreamer0.10-bad-plugins',
  'gstreamer0.10-base',
  'gstreamer0.10-base-plugins',
  'gstreamer0.10-ffmpeg',
  'gstreamer0.10-good',
  'gstreamer0.10-good-plugins',
  'gstreamer0.10-python',
  'gstreamer0.10-ugly',
  'gstreamer0.10-ugly-plugins',
  'gstreamer0.10-mm',
  'clementine',
]

 package {$clementine_packages:
    ensure  => present,
  }

}
