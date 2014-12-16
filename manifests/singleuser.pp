# Manage /etc/inittab
class sox::singleuser(
  $fixit = $::sox_fix,
) {
  
  tag 'SV-50387r1_rule', '14.4'
  
  if $fixit {
    augeas { "inittab_su:S:wait:/sbin/sulogin":
      context => "/files/etc/inittab/su",
      changes => [
        "set runlevels S",
        "set action wait",
        "set process /sbin/sulogin",
      ],
    }
  }
}
