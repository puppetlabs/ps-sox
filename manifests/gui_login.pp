# Manage /etc/inittab
class sox::gui_login(
  $fixit = false,
) {
  if $fixit {
    augeas { "inittab_3":
      context => "/files/etc/inittab/id",
      changes => [
        "set runlevels 3",
      ],
    }
  }
}
