Facter.add(:check_root_path) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    path = Facter.value(:path)
    if Facter.value(:path) =~ /(:\.|\.:|:\/tmp|\/tmp.*:|:\/var\/tmp|\/var\/tmp.*:)/
        'Failed'
    else
        'Passed'
    end
  end
end
