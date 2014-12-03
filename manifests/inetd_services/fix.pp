## This defined type will ensure a specified service is disabled.
## It will also check the service against an array to determine if it should
##
## Caveats:
##   - Services should be managed by their component module
##   - This uses defined(), which is subject to parse-order
##   - This uses a collector to disable services present in the catalog
##     matching the title, which could conflict with what's described
##     elsewhere.
##
define sox::inetd_services::fix (
  $service = $title,
) {

  ## These services should not be "fixed" automatically
  $manually_fix = [
    'telnet',
    'ftp',
    'rsh',
    'rexec',
    'rlogin',
  ]

  if grep($manually_fix,$service) {
    notify { "${service}: Automatic fix not available, please fix manually": }
  }
  else {
    if !defined(Service[$service]) {
      service { $service:
        enable => false,
      }
    }
    else {
      Service<| title == $service |> {
        enable => false,
      }
    }
  }
}
