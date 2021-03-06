class sox::account_passwds(
  $fixit = $::sox_fix,
  $force = false,
  $warn  = true,
) {
  
  tag 'SV-50298r1_rule', '15.2'
  
  if $fixit {
    # Extract the fact as puppet array so it can create the resource below
    $users = split($::fix_account_passwds,',')

    # Create a series of user resources if not defined with a password set to '!!'
    sox::account_passwds::fix{ $users:
      force => $force,
      warn  => $warn,
    }
  }
}

