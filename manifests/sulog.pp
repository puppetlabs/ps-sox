class sox::sulog (
  $fixit = false,
) {

  if $fixit {
    shellvar { 'fix_sulog':
      ensure   => present,
      target   => '/etc/defaut/su',
      variable => 'SULOG',
      value    => '/var/adm/sulog',
    }
  }
}
