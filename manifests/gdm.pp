# Add entries to /etc/X11/gdm/gdm.conf
class sox::gdm(
  $fixit = false,
) {

  # Puppet will fail if this file does not exist
  # The fact makes this idempotant
  if $::check_gdm == 'Failed' and $fixit {
    ini_setting { 'gdm.conf AllowRoot=false:':
      path    => '/etc/X11/gdm/gdm.conf',
      setting => 'AllowRoot',
      section => '',
      value   => 'false',
    }
  }
}
