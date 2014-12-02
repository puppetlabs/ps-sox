class sox::account_passwds(
  $fixit = false,
  $force = false,
  $warn  = true,
) {
  if $fixit {
    $users = split($::fix_account_passwds,',')
      sox::account_passwds::fix{ $users:
          force => $force,
          warn  => $warn,
      }
  }
}

