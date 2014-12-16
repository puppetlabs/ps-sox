class sox::root_path (
  $fixit = $::sox_fix,
  $warn  = true,
) {
  
    tag 'SV-37372r1_rule', '15.5' 
  
    if $::check_root_path == 'Failed' and $fixit and $warn {
        notify {"${name}: Automatic fix not available, please fix manually":}
    }
}

