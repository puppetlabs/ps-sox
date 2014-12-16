class sox::disable_accounts(
  $fixit = false,
  $force = false,
  $warn  = true,
) {
  
  tag 'SV-50297r2_rule', '15.1'
  
  if $fixit {
    # Extract the fact as puppet array so it can create the resource below
    $users = split($::fix_disable_accounts,',')
    # Create a series of user resources if not defined with a password set to '!!'
    sox::account_passwds::fix{ $users:
        force => $force,
        warn  => $warn,
    }
  }
}

