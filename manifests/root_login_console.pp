# Manage /etc/securetty
class sox::root_login_console(
  $fixit = $::sox_fix,
) {
  if $fixit {
    augeas { "securetty":
      context => "/files/etc/securetty",
      changes => [
        "rm *[.=~ regexp('^(ttyp|pts).*$')]",
      ],
    }
  }
}
