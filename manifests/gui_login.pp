# Manage gui_login.conf
class sox::gui_login(
  $fixit = false,
) {
  if $::gui_login == 'Failed' and $fixit {
    augeas { "inittab_3":
      context => "/files/etc/inittab",
      changes => [
        "runlevels 3",
      ],
    }
  }
}
