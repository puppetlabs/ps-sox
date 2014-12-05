Facter.add(:check_su) do
  confine :sox_su => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/usr/bin/sudo' and File.exist? '/etc/sudoers'
      'Passed'
    else
      'Failed'
    end
  end
end
