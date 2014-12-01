class sox::xfs (
  $fixit = false,
) {
  if $fixit {
    service {'xfs':
      ensure => stopped,
      enable => false,
    }
  }
}
