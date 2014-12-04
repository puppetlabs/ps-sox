## This defined type will ensure a specified service is disabled.
## It takes a $status hash as a parameter that should look like:
##   service => 'failed'
##   or
##   service => 'investigate'
## Services that are 'failed' can attempt to be "fixed"
## Services that are flagged with 'investigate' will simply print a message.
##
## Parameters:
##  [*status*]
##    This is the output of $::fix_boot_services returned as a hash
##
##  [*service*]
##    This defaults to the resource title.  The name of the service we want to
##    manage.
##
##  [*warn*]
##    Defaults to true.  If the service is managed outside of the sox module,
##    return a warning.
##
##  [*force*]
##    Defaults to false. If the service is managed outside of the sox module,
##    attempt to override it here.
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
  $warn    = true,
  $force   = false,
) {

  validate_hash($status)
  validate_bool($warn)
  validate_bool($force)

  $service_params = {
    enable => false,
  }

  if $status[$service] == 'failed' {
   if !defined_with_params(Service[$service],$service_params) {
      service { $service:
        enable => false,
      }
    }
    else {
      if $force {
        Service<| title == $service |> {
          enable => false,
        }
      }
      else {
        if $warn {
          notify { "Service[${service}] is being managed outside of sox specifications.": }
        }
      }
    }
  }
  else {
    notify { "${service}: Automatic fix not available, please investigate": }
  }

}
