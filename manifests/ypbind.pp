class sox::ypbind (
  $fixit = $::sox_fix,
) {
  
  tag 'SV-50405r2_rule'
  
  if $fixit {
    service{ 'ypbind':
      ensure => stopped,
      enable => false,
    }
  }
}
