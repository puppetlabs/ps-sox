class sox::installed_software (
  $fixit = $::sox_fix,
) {

  if $fixit {
    $packages = [
      'sudo',
      'tcp_wrappers',
    ]

    package { $packages:
      ensure => 'installed',
    }
  }
}
