# Manage check_root_login_console.conf
class sox::check_root_login_console(
  $fixit = false,
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
