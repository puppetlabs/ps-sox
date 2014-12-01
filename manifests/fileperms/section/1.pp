class sox::fileperms::section::1 (
  $fixit = false,
) {

   if $fixit {
     file {'/var/log/btmp':
         ensure => 'file',
         owner  => 'root',
         group  => 'utmp',
     }
   }
}
