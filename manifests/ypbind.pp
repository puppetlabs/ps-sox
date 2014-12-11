class sox::ypbind (
  $fixit = $::sox_fix,
) {
  if $fixit {
    service{ 'ypbind':
      ensure => stopped,
      enable => false,
    }
  }
}
