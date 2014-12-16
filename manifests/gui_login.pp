# http://www.stigviewer.com/stig/red_hat_enterprise_linux_5/2014-04-02/finding/V-756
class sox::gui_login(
  $fixit = $::sox_fix,
) {
  
  tag 'SV-37350r1_rule', '7.1'
  
  if $fixit {
    augeas { "inittab_3":
      context => "/files/etc/inittab/id",
      changes => [
        "set runlevels 3",
      ],
    }
  }
}
