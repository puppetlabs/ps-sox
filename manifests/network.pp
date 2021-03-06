# https://forge.puppetlabs.com/fiddyspence/sysctl
# As this was the sysctl module choosen over augeasproviders its modeled here
class sox::network(
    $fixit = $::sox_fix,
) {

  $tags = [
    'SV-50324r1_rule',
    'SV-50325r1_rule',
    'SV-50327r1_rule',
    'SV-50330r1_rule',
    'SV-50336r1_rule',
    'SV-50340r1_rule',
    '9.1'
  ]
  
  tags $tags

  if $fixit {
    Sysctl {
      ensure     => 'present',
      permanent => 'yes',
    }
    sysctl {
      'net.ipv4.tcp_max_syn_backlog':               value => '4096';
      'net.ipv4.tcp_syncookies':                    value => '1';
      'net.ipv4.conf.all.accept_source_route':      value => '0';
      'net.ipv4.conf.all.accept_redirects':         value => '0';
      'net.ipv4.conf.all.secure_redirects':         value => '0';
      'net.ipv4.conf.default.rp_filter':            value => '1';
      'net.ipv4.conf.default.accept_source_route':  value => '0';
      'net.ipv4.conf.default.accept_redirects':     value => '0';
      'net.ipv4.conf.default.secure_redirects':     value => '0';
      'net.ipv4.icmp_echo_ignore_broadcasts':       value => '1';
      'net.ipv4.ip_forward':                        value => '0';
      'net.ipv4.conf.all.send_redirects':           value => '0';
      'net.ipv4.conf.default.send_redirects':       value => '0';
    }
  }
}
