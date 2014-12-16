# Add entries to /etc/X11/gdm/gdm.conf
class sox::gdm(
  $fixit = $::sox_fix,
) {
  
  tag 'CCE-27230-2', '14.3'

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
