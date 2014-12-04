## This fact checks the status of service runlevel enablement.
## A list of services are listed below with various metadata to determine
## compliance.
##
## The status reported via 'chkconfig' is compared to  the :status for that
## service in our hash below to determine if it's compliant, non-compliant, or
## needs to be checked with something else.
## Compliance is also determined where the system is in a dmz or not.
##
## Service status descriptions:
##   'on':
##     If chkconfig reports the service is 'on', this is compliant.
##
##   'onplus':
##     A service listed below that has an "onplus" status requires
##     a separate check to be made (outside of this fact) to determine if it's
##     compliant or not.
##
##   'offstar':
##     A service with a status of 'offstar' passes compliance check, but should
##     be investigated, apparently.
##
##   'off':
##     The service should be 'off'.
##
## Requirements:
##   This needs a DMZ fact or some logic to determine if we're operating
##   in a DMZ.  The desired state of services depends on that.
##
## Provides:
##   check_boot_services
##     This fact reports Passed | Failed | Investigate
##     Refer to the 'status' description above.
##
##   fix_boot_services
##     This fact reports a JSON-formatted hash of services that were not a
##     hard "Passed".  This is either non-compliant services or services that
##     are deemed to be "investigated"
##     E.g. {"sshd":"failed","postfix":"investigate"}
##

require 'facter/util/soxsvc'
require 'json'

## TODO: Logic to determine if we're in a DMZ or not is needed.
## In the fact code further in this file, we're evaluating "in_dmz" and
## expecting a boolean.
in_dmz = false

## This (large) hash contains the services from 'check_boot_services.conf'
## Previously, this was a pipe-separated list of services and what their
## state was for dmz or int.  This should eventually be moved out of this file.
##
## This hash is made up of migrated data from 'check_boot_services.conf',
## which was a pipe-separated value file.  It's converted to a hash so that we
## can be more flexible with it (easier) in the future.  E.g. moving this data
## into an external YAML file.
services = {
  'acpid' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'amd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'anacron' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'apmd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'arptables_jf' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'arpwatch' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'auditd' => {
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'avahi-daemon' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'avahi-dnsconfd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'bgpd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'bluetooth' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'bootparamd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'capi' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'conman' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'cups' => {
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'cyrus-imapd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dc_client' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dc_server' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dhcdbd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dhcp6s' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dhcpd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dhcrelay' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dovecot' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'dund' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'firstboot' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'gpm' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'hidd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'hplip' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ibmasm' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'innd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ipmi' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ip6tables' => {
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'iptables' => {
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'irda' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'isdn' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'kadmin' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'kprop' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'krb524' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'krb5kdc' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'kudzu' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ldap' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'lisa' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'lm_sensors' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'mailman' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'mcstrans' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'mdmonitor' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'mdmpd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'microcode_ctl' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'mysqld' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'named' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'netplugd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'networkmanager' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'openibd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ospf6d' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ospfd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'pand' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'pcscd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'postgresql' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'privoxy' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'psacct' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'radiusd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'radvd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rarpd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rdisc' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'readahead_early' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'readahead_later' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'restorecond' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ripd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ripngd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rpcgssd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rpcidmapd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rpcsvcgssd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rstatd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rusersd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'rwhod' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'saslauthd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'sendmail' => {
    :int => {
      :autofix => true,
      :status  => 'onplus',
    },
    :dmz => {
      :autofix => true,
      :status  => 'onplus',
    },
  },
  'setroubleshoot' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'smartd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'snmptrapd' => {
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'spamassassin' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'squid' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'tog-pegasus' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'tux' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'vncserver' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'vsftpd' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => false,
      :status  => 'off',
    },
  },
  'wpa_supplicant' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'xend' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'xendomains' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'xfs' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'ypbind' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => false,
      :status  => 'off',
    },
  },
  'yppasswdd' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => false,
      :status  => 'off',
    },
  },
  'ypserv' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => false,
      :status  => 'off',
    },
  },
  'ypxfrd' => {
    :int => {
      :autofix => false,
      :status  => 'off',
    },
    :dmz => {
      :autofix => false,
      :status  => 'off',
    },
  },
  'yum-updatesd' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
  'zebra' => {
    :int => {
      :autofix => true,
      :status  => 'off',
    },
    :dmz => {
      :autofix => true,
      :status  => 'off',
    },
  },
}

## We'll build a hash of any non-passed services
fix_boot_services = {}

Facter.add(:check_boot_services) do
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  result = []
  services.each do |s,v|
    if Facter::Util::SOXSvc.service_exists?(s)
      if Facter::Util::SOXSvc.service_enabled?(s,4)

        ## TODO: Need to figure out dmz.  Probably another fact.
        if in_dmz
          ## Some services don't specify their desired status. We need to
          ## check if that's specified and fail if it isn't.
          if v.has_key?(:dmz) && v[:dmz].has_key?(:status)
            desired_status = v[:dmz][:status]
          else
            fix_boot_services[s] = 'failed'
            result << 'Failed'
            next
          end
        else
          if v.has_key?(:int) && v[:int].has_key?(:status)
            desired_status = v[:int][:status]
          else
            fix_boot_services[s] = 'failed'
            result << 'Failed'
            next
          end
        end

        case desired_status
          when /on|plus/
            ## Service state is "on" and should be "on" or
            ## If a service is described as "*plus", that means a different
            ## script needs to be ran to compliance check it.
            ## We'll just skip them in this fact for now.
            next
          when 'off'
            fix_boot_services[s] = 'failed'
            result << 'Failed'
            next
          when 'offstar'
            fix_boot_services[s] = 'investigate'
            result << 'Investigate'
            next
          else
            fix_boot_services[s] = 'failed'
            result << 'Failed'
        end

      else
        ## Service is not enabled
        result << 'Passed'
      end
    else
      ## Service does not exist
      result << 'Passed'
    end
  end
  setcode do
    if result.include?('Failed')
      'Failed'
    elsif result.include?('Investigate')
      'Investigate'
    else
      'Passed'
    end
  end
end

## Return a JSON-formatted hash of the services that didn't pass.
## E.g.
## {"sshd":"failed","postfix":"investigate"}
Facter.add(:fix_boot_services) do
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','3','4','5','6']
  setcode do
    fix_boot_services.to_json
  end
end

