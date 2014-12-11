class sox::ypserv (
  $fixit = $::sox_fix,
) {
  if $fixit {
    package { 'ypserv':
      ensure => absent,
    }
  }
}
