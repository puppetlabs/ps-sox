define sox::fileperms::fix (
  $perm,
  $owner,
  $gowner,
  $file_path   = $title,
  $warn        = true,
  $force       = false,
) {

  $file_params = {
      owner => $owner,
      group => $gowner,
      mode  => $perm,
      path  => $file_path,
  }

  # Check if the file is in the catalog with correct values
  if ! defined_with_params(File[$title],$file_params)  {

    # Create the resource with the hash above
    create_resources('file',{ $title = $file_params })
  }
  else {

   if $force {
     # Update the file in the catalog with correct values
     # While this assuage flexibility reqiurements it should be avoided
     # Due to debug concerns with developers code being rewitten
     File <| path == $file_path > {
         owner => $owner,
         group => $gowner,
         perm  => $file_path,
     }
   else
     # Warn if already defined in the catalog without sox values
     if $warn {
         notify {"${path} is being managed outside of sox specifications":}
     }
   }
  }
}
