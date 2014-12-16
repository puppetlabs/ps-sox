class sox::xfs (
  $fixit = $::sox_fix,
) {
  
  tag '8.1'
  
  if $fixit {
    service {'xfs':
      ensure => stopped,
      enable => false,
    }
  }
}
