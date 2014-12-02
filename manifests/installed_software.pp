class sox::installed_software (
  $fixit = true,
) {
  validate_bool($fixit)

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
