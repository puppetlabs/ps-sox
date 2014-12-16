# Manage /etc/auto.misc
class sox::disable_rmmount(
  $fixit = $::sox_fix,
) {
  if $fixit {
    augeas { "/etc/auto.misc":
      context => "/etc/auto.misc",
      changes => [
        "rm *[.=~ regexp('^(ttyp|pts).*$')]",
      ],
      tag => '13.3',
    }
  }
}
