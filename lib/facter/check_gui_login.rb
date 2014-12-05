require 'augeas'
Facter.add(:check_gui_login) do
  confine :sox_gui_login => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    status = 'Failed'
    Augeas::open do |aug|
      if aug.get('/files/etc/inittab/id/runlevels') == '3'
        status = 'Passed'
      end
    end
    status
  end
end
