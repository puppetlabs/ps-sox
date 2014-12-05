ROOT_UID = 0
SYS_GID  = 3
check = []
Facter.add(:check_loginlog) do
  confine :sox_loginlog => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    status = 'Passed'
    if File.exist? '/var/adm/loginlog'
      # Assume failure for sub checks
      check[0],check[1],check[2] = 'Failed','Failed','Failed'

      # Run through checks
      loginlog = File.stat('/var/adm/loginlog')
      check[0] = 'Passed' if ( "%o" % loginlog.mode ) == '100600'
      check[1] = 'Passed' if loginlog.uid == ROOT_UID
      check[2] = 'Passed' if loginlog.gid == SYS_GID
      status = 'Failed' if check.include?('Failed')
    else
      # If file does not exist then check passes
      status = 'Passed'
    end
    status
  end
end
