class sox::sulog (
  $fixit = $::sox_fix,
) {
  
  tag 'SV-39850r1_rule', '14.4'

  if $fixit {
    shellvar { 'fix_sulog':
      ensure   => present,
      target   => '/etc/defaut/su',
      variable => 'SULOG',
      value    => '/var/adm/sulog',
    }
  }
}
