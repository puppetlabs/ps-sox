## Fact to check whether certain services are enabled via chkconfig.
## Currently supports RedHat family < 7 (doesn't support systemd).

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

## Method to determine if the service even exists by checking with 'chkconfig'
def service_exists?(service)
  system("/sbin/chkconfig --list #{service} >/dev/null 2>&1")
end

## Method to check if a service is enabled in a certain runlevel or via xinetd
## If it's xinetd, the runlevel doesn't really matter.
def service_enabled?(service,runlevel=check_runlevel)
  runlevel = runlevel.to_i

  ## Get the status line from 'chkconfig'
  status = Facter::Util::Resolution.exec("/sbin/chkconfig --list #{service}")

  ## If there's a colon in the output, it's highly likely not an xinetd service
  ## xinetd services look like:
  ##   rsync        on
  if status =~ /:/
    ## init
    ## Get the runlevels into an array
    chkconfig = status.split
    chkconfig.shift
    return true if chkconfig[runlevel] =~ /:on/
  else
    ## xinet
    return true if status =~ /\bon$/
  end
  return false
end

Facter.add(:check_inetd_services) do
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  setcode do
    result = []
    services.each do |service|
      if service_exists?(service)
        if service_enabled?(service,check_runlevel)
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
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  setcode do
    fix_services.join(',')
  end
end
