class sox::root_path (
  $fixit = $::sox_fix,
  $warn  = true,
) {
    if $::check_root_path == 'Failed' and $fixit and $warn {
        notify {"${name}: Automatic fix not available, please fix manually":}
    }
}

