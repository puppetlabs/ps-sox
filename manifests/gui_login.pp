# http://www.stigviewer.com/stig/red_hat_enterprise_linux_5/2014-04-02/finding/V-756
class sox::gui_login(
  $fixit = false,
) {
  if $fixit {
    augeas { "inittab_3":
      context => "/files/etc/inittab/id",
      changes => [
        "set runlevels 3",
      ],
      tag => 'SV-37350r1_rule',
    }
  }
}
