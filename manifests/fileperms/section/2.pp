class sox::fileperms::section::1 (
  $fixit = false,
) {

   if $fixit {

     $files = [
       '/var/log/boot.log',
       '/var/log/cron',
       '/var/log/dmesg',
       '/var/log/ksyms',
       '/var/log/httpd',
       '/var/log/lastlog',
       '/var/log/maillog',
       '/var/log/mailman',
       '/var/log/news',
       '/var/log/pgsql',
       '/var/log/sa',
       '/var/log/samba',
       '/var/log/scrollkeeper.log',
       '/var/log/secure',
       '/var/log/spooler',
       '/var/log/squid',
       '/var/log/vbox',
    ]

     file {$files:
         ensure => 'file',
         owner  => 'root',
         group  => 'utmp',
     }
   }
}
