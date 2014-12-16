Facter.add(:check_ypserv) do
  confine :sox_ypserv => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if system('rpm -q ypserv >/dev/null 2>&1')
      'Failed'
    else
      'Passed'
    end
  end
end