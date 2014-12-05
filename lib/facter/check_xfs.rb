Facter.add(:check_xfs) do
  confine :sox_xfs => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if system('service xfs status >/dev/null 2>&1')
      'Failed'
    else
      'Passed'
    end
  end
end
