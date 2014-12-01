Facter.add(:check_xfs) do
  confine :kernel => 'Linux'
  setcode do
    if system('service xfs status')
      'Failed'
    else
      'Passed'
    end
  end
end
