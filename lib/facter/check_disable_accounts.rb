require 'etc'

 DISABLED_ACCOUNTS = [
     'bin',
     'daemon',
     'adm',
     'lp',
     'sync',
     'shutdown',
     'halt',
     'mail',
     'news',
     'uucp',
     'operator',
     'games',
     'go',
     'pher',
     'ftp',
     'nobody',
     'dbus',
     'vcsa',
     'rpm',
     'haldaemon',
     'netdump',
     'nscd',
     'sshd',
     'rpc',
     'mailnull',
     'smmsp',
     'rpcuser',
     'nfsnobody',
     'pcap',
     'apache',
     'squid',
     'webalizer',
     'xfs',
     'ntp',
     'pegasus',
 ]
troubled_accounts = []
Facter.add(:check_disable_accounts) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['5','6']
  setcode do
    checks = {}
    # Loop through /etc/passwd
    Etc.passwd do |user|
      # Could clean this up with a select
      next unless DISABLED_ACCOUNTS.include? user.name
      l = `passwd -S #{user.name}`.split
      if l[1] =~ /(NL|LK)/
        checks[user.name] = 'Passed'
      else
        checks[user.name] = 'Failed'
        troubled_accounts << user.name
      end
    end

   ## Return 'failed' if any of the packages are not installed
   if checks.detect {|k,v| v == 'Failed'}
     'Failed'
   else
     'Passed'
   end

  end
end

Facter.add(:check_disable_accounts) do
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['7','2','3','4']
  setcode do
    checks = {}
    # Loop through /etc/passwd
    Etc.passwd do |user|
      # Could clean this up with a select
      next unless DISABLED_ACCOUNTS.include? user.name
      l = `passwd -S #{user.name}`.split
      if l.last =~ /.*(locked|Alternate authentication).*/i
        checks[user.name] = 'Passed'
      else
        checks[user.name] = 'Failed'
        troubled_accounts << user.name
      end
    end

   ## Return 'failed' if any of the packages are not installed
   if checks.detect {|k,v| v == 'Failed'}
     'Failed'
   else
     'Passed'
   end

  end
end

Facter.add(:fix_disable_accounts) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    troubled_accounts.join(',')
  end
end
