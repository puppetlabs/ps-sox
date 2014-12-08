class sox::6000tcp (
  $check   = true,
  $fixit   = $::sox_fix,
) {
  if $fixit {
    notify {"${name}: Automatic fix not available, please fix manually":}
  }


}
