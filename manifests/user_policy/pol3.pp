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
    #target    => "/etc/pam.d/${pamfile}",
  }
  
  pam { "set ${pamfile} to use account required pam_tally2.so":
    ensure   => present,
    service  => $pamfile,
    type     => 'account',
    control  => 'required',
    module   => 'pam_tally2.so',
    position => 'before first',
    #target   => "/etc/pam.d/${pamfile}",
  }
  
  # # insert new place marker auth include after existing pam_tally2.so then remove it
  # augeas { "${name}/pam_tally2_reset":
  #   context  => "/files/${pamfile}",
  #   changes  => [
  #     "ins 01 before *[type = 'auth'][control = 'include']",
  #     "set 01/type auth",
  #     "set 01/control required",
  #     "set 01/module pam_tally2.so",
  #     "rm *[type = 'auth'][control = 'required'][module = 'pam_tally2.so']",
  #   ],
  #   onlyif => "match *[type = 'auth'][control = 'required'][module = 'pam_tally2.so'] size > 0",
  # }
  #
  # # update any existing pam_tally2.so entry to have correct settings (this will include new entry from insert above)
  # augeas { "${name}/pam_tally2_update":
  #   context  => "/files/${pamfile}/*[type = 'auth'][control = 'required'][module = 'pam_tally2.so']",
  #   changes  => [
  #     "rm argument",
  #     "set argument[1] deny=3",
  #     "set argument[2] onerr=fail",
  #   ],
  #   require => Augeas["${name}/pam_tally2_reset"],
  #
  # }
  #
  # # insert new place marker auth include after existing pam_tally2.so then remove it
  # augeas { "${name}/pam_tally2_account":
  #   context  => "/files/${pamfile}",
  #   changes  => [
  #     "ins 01 before *[type = 'account'][control = 'include']",
  #     "set 01/type account",
  #     "set 01/control required",
  #     "set 01/module pam_tally2.so",
  #     "rm *[type = 'account'][control = 'required'][module = 'pam_tally2.so']",
  #   ],
  #   onlyif => "match *[type = 'account'][control = 'required'][module = 'pam_tally2.so'] size > 0",
  # }
}
