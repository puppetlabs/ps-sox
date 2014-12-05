require 'augeas'
fix_network = []
Facter.add(:check_network) do
  confine :kernel => 'Linux'
  confine :sox_network => 'enabled'
  setcode do
    sysctl_values = {
      'net.ipv4.tcp_max_syn_backlog'               => '4096',
      'net.ipv4.tcp_syncookies'                    => '1',
      'net.ipv4.conf.all.accept_source_route'      => '0',
      'net.ipv4.conf.all.accept_redirects'         => '0',
      'net.ipv4.conf.all.secure_redirects'         => '0',
      'net.ipv4.conf.default.rp_filter'            => '1',
      'net.ipv4.conf.default.accept_source_route'  => '0',
      'net.ipv4.conf.default.accept_redirects'     => '0',
      'net.ipv4.conf.default.secure_redirects'     => '0',
      'net.ipv4.icmp_echo_ignore_broadcasts'       => '1',
      'net.ipv4.ip_forward'                        => '0',
      'net.ipv4.conf.all.send_redirects'           => '0',
      'net.ipv4.conf.default.send_redirects'       => '0',
    }
    checks = {}
    # Assume failure as file must exist with line to pass
    Augeas::open do |aug|
      aug.context = '/files/etc/sysctl.conf'
      sysctl_values.each do |key,value|
          # Check the current value against the required value
          if aug.get(key) == value
            checks[key] = 'Passed'
          else
            fix_network << key
            checks[key] = 'Failed'
          end
      end
    end
    # Return 'failed' if any of the keys have incorrect values
    if checks.detect {|k,v| v == 'Failed'}
      'Failed'
    else
      'Passed'
    end
  end
end

Facter.add(:fix_network) do
  confine :kernel => 'Linux'
  confine :sox_network => 'enabled'
  setcode do
    fix_network.join(',')
  end
end
