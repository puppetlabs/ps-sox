## If the FTP service is enabled, we need to ensure it's configured to log.
## The FTP daemon varies among operating system versions.
## If the FTP service is disabled, it's considered to be compliant.
##
## This fact assumes that 'wu-ftpd' and 'gssftp' are started via xinetd on
## EL2, EL4, and EL7
##
## Reference:
## http://www.stigviewer.com/stig/red_hat_enterprise_linux_5/2014-04-02/finding/V-845
require 'augeas'

## Check if the specified service is "on" via 'chkconfig'
def service_enabled?(service)
  return true if Facter::Util::Resolution.exec("/sbin/chkconfig --list
                                               #{service}") =~ /:on/
  false
end

Facter.add(:check_ftplogging) do
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['5','6']
  setcode do
    status = 'Failed'
    if service_enabled?('vsftpd')
      Augeas::open do |aug|
        if aug.get('/files/etc/vsftpd/vsftpd.conf/log_ftp_protocol') == 'YES'
          status = 'Passed'
        else
          status = 'Failed'
        end
      end
    else
      status = 'Passed'
    end
    status
  end
end

Facter.add(:check_ftplogging) do
  confine :kernel => 'Linux'
  confine :operatingsystemmajrelease => ['2','4','7']

  case Facter.value(:operatingsystemmajrelease)
    when /2|7/
      service = 'wu-ftpd'
    else
      service = 'gssftp'
  end

  setcode do
    status = 'Failed'
    if service_enabled?(service)
      Augeas::open do |aug|
        ## Parse each 'server_args' value
        server_args =
          aug.match("/files/etc/xinetd.d/#{service}/service/server_args/*").map \
          { |a| aug.get(a) }

        ## Ensure the '-l' argument is specified at least once
        ## It can be passed multiple times to increase verbosity
        if server_args.any? { |arg| /-l+/ =~ arg }
          status = 'Passed'
        else
          status = 'Failed'
        end
      end
    else
      status = 'Passed'
    end
    status
  end
end
