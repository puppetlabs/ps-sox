#http://www.stigviewer.com/stig/solaris_11_x86/2014-04-23/finding/V-48089
class sox::keyserv(
  $fixit = false,
) {
  if $::check_keyserv == 'Failed' and $fixit {
    shellvar { '/etc/default/keyserv:ENABLE_NOBODY_KEYS=NO':
      ensure   => present,
      target   => '/etc/default/keyserv',
      variable => 'ENABLE_NOBODY_KEYS',
      value    => 'NO',
      tag      => 'SV-60961r1_rule',
    }
  }
}
