# Manage /etc/auto.misc
class sox::serial(
  $fixit = $::sox_fix,
) {
  
  tag 'SV-50295r1_rule', '18.1' 
  
  if $fixit {
    augeas { "/etc/securetty":
      context => "/etc/securetty",
      changes => [
        "rm /files/etc/securetty/*[.=~ regexp('^ttyS[0-9]+$')]",
      ],
    }
  }
}