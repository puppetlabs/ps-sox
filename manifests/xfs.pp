class sox::xfs (
  $fixit = $::sox_fix,
) {
  if $fixit {
    service {'xfs':
      ensure => stopped,
      enable => false,
    }
  }
}
