require 'augeas'
Facter.add(:check_singleuser) do
  confine :sox_singleuser => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    # Assume failure as file must exist with line to pass
    status = 'Failed'
    Augeas::open do |aug|
      aug.get('/files/etc/inittab/su/runlevels') == 'S' &&
      aug.get('/files/etc/inittab/su/action')    == 'wait' &&
      aug.get('/files/etc/inittab/su/process')   == '/sbin/sulogin' &&
      status = 'Passed'
    end
    status
  end
end
