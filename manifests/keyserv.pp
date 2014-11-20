# Manage keyserv.conf
class sox::keyserv(
  $fixit = false,
) {
  if $::check_keyserv == 'Failed' and $fixit {
    ini_setting { 'keyserv.conf AllowRoot=false:':
      path    => '/etc/X11/keyserv/keyserv.conf',
      setting => 'AllowRoot',
      section => '',
      value   => 'false',
    }
  }
}
