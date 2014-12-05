## Fact to check whether certain services are enabled via chkconfig.
## Currently supports RedHat family < 7 (doesn't support systemd).

require 'facter/util/soxsvc'

## What runlevel to check
check_runlevel = 2

## Array of services to check
services = [
  'amanda',
  'amandaidx',
  'amidxtape',
  'auth',
  'chargen-dgram',
  'chargen-stream',
  'cvs',
  'cyrus-imapd',
  'daytime-dgram',
  'daytime-stream',
  'discard-dgram',
  'discard-stream',
  'dovecot',
  'echo-dgram',
  'echo-stream',
  'eklogin',
  'ekrb5-telnet',
  'gssftp',
  'klogin',
  'krb5-telnet',
  'kshell',
  'ktalk',
  'ntalk',
  'rcp',
  'rexec',
  'rlogin',
  'rsh',
  'shell',
  'talk',
  'tcpmux-server',
  'telnet',
  'tftp',
  'time-dgram',
  'time-stream',
  'uucp',
  'vsftpd',
  'wu-ftpd',
]

## We'll collect the non-compliant services in this array to use in a second
## fact to report them.
fix_services = []

Facter.add(:check_inetd_services) do
  confine :sox_inetd_services => 'enabled'
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  setcode do
    result = []
    services.each do |service|
      if Facter::Util::SOXSvc.service_exists?(service)
        if Facter::Util::SOXSvc.service_enabled?(service,check_runlevel)
          fix_services << service
          result << 'Failed'
        else
          result << 'Passed'
        end
      else
        ## If the service doesn't exist, it's a pass
        result << 'Passed'
      end
    end
    if result.include?('Failed')
      'Failed'
    else
      'Passed'
    end
  end
end

## Fact to list the services that are non-compliant as a comma-separated list
Facter.add(:fix_inetd_services) do
  confine :sox_inetd_services => 'enabled'
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  setcode do
    fix_services.join(',')
  end
end
