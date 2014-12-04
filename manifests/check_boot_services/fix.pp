## This defined type will ensure a specified service is disabled.
## It takes a $status hash as a parameter that should look like:
##   service => 'failed'
##   or
##   service => 'investigate'
## Services that are 'failed' can attempt to be "fixed"
## Services that are flagged with 'investigate' will simply print a message.
##
## Caveats:
##   - Services should be managed by their component module
##   - This uses defined(), which is subject to parse-order
##   - This uses a collector to disable services present in the catalog
##     matching the title, which could conflict with what's described
##     elsewhere.
##
define sox::check_boot_services::fix (
  $status,
  $service = $title,
) {

  if $status[$service] == 'failed' {
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
  else {
    notify { "${service}: Automatic fix not available, please investigate": }
  }

}
