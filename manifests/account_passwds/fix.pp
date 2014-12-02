define sox::account_passwds::fix (
  $warn        = true,
  $force       = false,
) {

  $user_params = {
      ensure => 'present',
      name   => $name,
      passwd => '!!',
  }

  # Check if the user is in the catalog with correct values
  if ! defined_with_params(User[$title],$user_params)  {
    user { $title:
      ensure => $user_params['ensure'],
      name   => $user_params['name'],
      passwd => $user_params['passwd']
    }
  }
  else {

   if $force {
     # Update the user in the catalog with correct values
     # While this assuage flexibility reqiurements it should be avoided
     # Due to debug concerns with developers code being rewitten
     User <| name == $name |> {
       ensure => $user_params['ensure'],
       name   => $user_params['name'],
       passwd => $user_params['passwd']
     }
   } else {
     # Warn if already defined in the catalog without sox values
     if $warn {
         notify {"User[${title}] is being managed outside of sox specifications":}
     }
   }
  }
}
