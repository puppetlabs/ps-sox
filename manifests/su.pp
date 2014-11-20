# Manage su.conf
class sox::su(
  $fixit = false,
) {
  if $::check_su == 'Failed' and $fixit {
      notify {'Automatic fix not available, please fix manually':}
  }
}
