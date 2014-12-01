Facter.add(:check_su) do
  confine :kernel => 'Linux'
  setcode do
    if system('service xfs status')
      'Failed'
    else
      'Passed'
    end
  end
end
