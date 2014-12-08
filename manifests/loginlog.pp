class sox::loginlog (
  $fixit = $::sox_fix,
) {
    file {'/var/adm/loginlog':
      ensure => 'file',
      owner  => 'root',
      group  => 'sys',
      mode   => '0600',
    }
}
