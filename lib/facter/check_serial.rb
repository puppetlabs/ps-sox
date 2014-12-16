Facter.add(:check_serial) do
  confine :sox_serial => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    status = 'Passed'
    Augeas::open do |aug|
      aug.get('/files/etc/securetty').each do |tty|
        puts tty
        if tty =~ /^ttyS/
          status = 'Failed'
          exit
        end
      end
    end
    status
  end
end
