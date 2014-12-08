## This class uses the services reported by the 'fix_inetd_services' fact
## to make them compliant (disabled).
class sox::inetd_services (
  $fixit = $::sox_fix,
) {

  $tags = [
    '3.2',
    'SV-26667r1_rule',
    'SV-26671r1_rule',
    'SV-26669r1_rule',
    'SV-26673r1_rule',
    'SV-37444r1_rule',
  ]

  tag $tags

  $services = split($::fix_inetd_services, ',')

  sox::inetd_services::fix { $services: }

}
