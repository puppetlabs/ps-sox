# Manage su.conf
class sox::su(
  $fixit = false,
  $warn  = true,
) {
  if $::check_su == 'Failed' and $fixit and $warn {
    notify {"${name}: Automatic fix not available, please fix manually":}
  }
}
