class sox::fileperms (
  $fixit = true,
) {

  if $fixit {

    $files = [
        '/var/log/wtmp',
        '/var/log/messages',
        '/var/log/secure',
        '/var/log/maillog',
        '/var/log/spooler',
        '/var/log/boot.log',
        '/var/log/cron',
    ]

   file {$files:
     mode   => '0600',
   }




  }
}
