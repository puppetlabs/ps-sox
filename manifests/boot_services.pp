##
## fix_boot_services returns a JSON-formatted hash of services that are not
## considered compliant.  The hash is structured as such:
## E.g. {"sshd":"failed","postfix":"investigate"}
## If a service is tagged with 'investigate', we don't want to "fix" it.
##
class sox::boot_services (
  $fixit = $::sox_fix,
  $force = false,
  $warn  = true,
) {

  validate_bool($force)
  validate_bool($warn)

  if $::fix_boot_services {
    $services = keys(parsejson($::fix_boot_services))

    sox::boot_services::fix { $services:
      status => parsejson($::fix_boot_services),
      force  => $force,
      warn   => $warn,
    }
  }
}
