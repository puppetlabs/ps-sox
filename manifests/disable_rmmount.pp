# Manage /etc/auto.misc
class sox::check_root_login_console(
  $fixit = false,
) {
  if $fixit {
    augeas { "/etc/auto.misc":
      context => "/etc/auto.misc",
      changes => [
        "rm *[.=~ regexp('^(ttyp|pts).*$')]",
      ],
    }
  }
}
