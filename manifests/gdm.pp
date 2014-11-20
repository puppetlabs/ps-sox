class sox::gdm(
) {
  file_line { 'AllowRoot:/etc/X11/gdm/gdm.conf':
    path  => '/etc/X11/gdm/gdm.conf',
    line  => 'AllowRoot=false',
    match => 'AllowRoot=.*',
  }
}
