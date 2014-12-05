require 'augeas'
Facter.add(:check_syslog) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    # Assume failure as file must exist with line to pass
    status = 'Failed'
    Augeas::open do |aug|
      aug.context = '/files/etc/syslog.conf'
      match = aug.match("entry[./action/file = '/var/log/secure'][./selector/facility = 'authpriv.notice']")
      if match.empty?
          status = 'Failed'
      else
          status = 'Passed'
      end
    end
    status
  end
end
