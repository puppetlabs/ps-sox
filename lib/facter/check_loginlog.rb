ROOT_UID = 0
SYS_GID  = 3
Facter.add(:check_loginlog) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/var/adm/loginlog'
      # Assume failure
      check[0],check[1],check[2] = 'Failed','Failed','Failed'

      # Run through checks
      loginlog = File.stat('/var/adm/loginlog')
      check[0] = 'Passed' if ( "%o" % loginlog.mode ) == '100600'
      check[1] = 'Passed' if loginlog.uid == ROOT_UID
      check[2] = 'Passed' if loginlog.gid == SYS_GID
      status = 'Failed' if check.include?('Failed')
    else
      status = 'Passed'
    end
    status
  end
end
