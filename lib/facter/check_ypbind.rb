Facter.add(:check_ypbind) do
  confine :sox_ypbind => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if system('rpm -q ypbind >/dev/null 2>&1')
      'Failed'
    else
      'Passed'
    end
  end
end