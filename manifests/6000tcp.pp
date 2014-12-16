class sox::6000tcp (
  $check   = true,
  $fixit   = $::sox_fix,
) {
  
  tag 'SV-50475r1_rule', '14.5'
  
  if $fixit {
    notify {"${name}: Automatic fix not available, please fix manually":}
  }


}
