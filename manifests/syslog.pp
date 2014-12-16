# Manage /etc/syslog.conf
class sox::syslog(
  $fixit = $::sox_fix,
) {
  
  tag 'CCI-000126', '10.1'
  
  if $fixit {

    # Ensure the service is in the catalog if this an apply
    if ! defined(Service['syslogd']) {
        service {'syslogd':
          ensure => 'running',
          enable => true,
        }
    }

    augeas { "authpriv.notice_/var/log/secure_/etc/syslog.conf":
      context    => '/files/etc/syslog.conf',
      changes => [
        'set entry[last()+1]/selector/facility authpriv.notice',
        'set entry[last()]/action/file /var/log/secure',
      ],
      onlyif => "match entry[./action/file = '/var/log/secure'][./selector/facility = 'authpriv.notice'] size == 0",
      notify => Service['syslog'],
    }
  }
}
