class sox::loginlog (
  $fixit = false,
) {
    file {'/var/adm/loginlog':
      ensure => 'file',
      owner  => 'root',
      group  => 'sys',
      mode   => '0600',
    }
}
