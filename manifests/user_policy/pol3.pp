define sox::user_policy::pol3 (
    $pamfile = $name,
) {
  
  pam { "set ${pamfile} to use auth required pam_tally2.so deny=3 onerr=fail":
    ensure    => present,
    service   => $pamfile,
    type      => 'auth',
    control   => 'required',
    module    => 'pam_tally2.so',
    arguments => ['deny=3','onerr=fail'],
    position  => 'before first',
  }
  
  pam { "set ${pamfile} to use account required pam_tally2.so":
    ensure   => present,
    service  => $pamfile,
    type     => 'account',
    control  => 'required',
    module   => 'pam_tally2.so',
    position => 'before first',
  }
  
}
