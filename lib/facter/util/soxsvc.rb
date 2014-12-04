module Facter::Util::SOXSvc
  ## Method to determine if the service even exists by checking with 'chkconfig'
  def self.service_exists?(service)
    system("/sbin/chkconfig --list #{service} >/dev/null 2>&1")
  end

  ## Method to check if a service is enabled in a certain runlevel or via xinetd
  ## If it's xinetd, the runlevel doesn't really matter.
  def self.service_enabled?(service,runlevel=2)
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
end
