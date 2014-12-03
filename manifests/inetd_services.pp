## This class uses the services reported by the 'fix_inetd_services' fact
## to make them compliant (disabled).
class sox::inetd_services (
  $fixit = true,
) {

  $services = split($::fix_inetd_services, ',')

  sox::inetd_services::fix { $services: }

}
