class sox::ypserv (
  $fixit = $::sox_fix,
) {
  
  tag 'SV-50404r1_rule'
  
  if $fixit {
    package { 'ypserv':
      ensure => absent,
    }
  }
}
