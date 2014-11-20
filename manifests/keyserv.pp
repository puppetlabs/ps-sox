# Manage gdm.conf
class sox::gdm(
  $fixit = false,
) {
  if $::check_gdm == 'Failed' and $fixit {
    ini_setting { 'gdm.conf AllowRoot=false:':
      path    => '/etc/X11/gdm/gdm.conf',
      setting => 'AllowRoot',
      section => '',
      value   => 'false',
    }
  }
}
