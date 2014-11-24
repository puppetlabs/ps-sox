# Manage /etc/inittab
class sox::syslog(
  $fixit = false,
) {
  if $fixit {

    if ! defined(Service['syslogd'] {
        service {'syslogd':
          ensure => 'running',
          enable => true,
        }
    }

    augeas { "authpriv.notice_/var/log/secure":
      context    => '/files/etc/rsyslog.conf',
      changes => [
        'set entry[last()+1]/selector/facility authpriv.notice',
        'set entry[last()]/action/file /var/log/secure',
      ],
      onlyif => "match entry[./action/file = '/var/log/secure'][./selector/facility = 'authpriv.notice'] size == 0",
      notify => Service['syslog'],
    }
  }
}
