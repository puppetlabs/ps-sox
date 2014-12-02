class sox::installed_software (
  $fixit = true,
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
