require 'etc'
troubled_accounts = []
Facter.add(:check_account_passwds) do
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['5','6']
  setcode do
    checks = {}
    # Loop through /etc/passwd
    Etc.passwd do |user|
      l = `passwd -S #{user.name}`.split
      if l[1] =~ /(NL|LK|PS)/
        checks[user.name] = 'Passed'
      else
        checks[user.name] = 'Failed'
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

Facter.add(:check_account_passwds) do
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['7','2','3','4']
  setcode do
    checks = {}
    # Loop through /etc/passwd
    Etc.passwd do |user|
      l = `passwd -S #{user.name}`.split
      if l[1] =~ /.*Empty password.*/
        checks[user.name] = 'Failed'
      else
        checks[user.name] = 'Passed'
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

Facter.add(:fix_account_passwds) do
  confine :kernel => 'Linux'
  setcode do
    troubled_accounts.join(',')
  end
end
