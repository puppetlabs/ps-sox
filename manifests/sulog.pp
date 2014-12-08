class sox::sulog (
  $fixit = $::sox_fix,
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
