## This class will ensure the specified files that set a umask are setting
## the umask to the specific value.
##
## This is fairly naive and brute-force.  The 'sox::default_umask::fix'
## defined type does the work here.  It takes a 'file' and 'umask' parameter.
## The 'file' defaults to the title.
##
## It will check for any non-commented occurance of 'umask' in the target file
## and ensure it's set to the specified 'umask' (defaults to 022). It will not
## evaluate additional files that are *sourced* by the target file.  It will
## not consider conditional logic within the file (e.g. bash if statements).
##
class sox::default_umask (
  $fixit = true,
) {

  $files = [
    '/etc/bashrc',
    '/etc/profile',
  ]

  ## Pass each file specified to a defined type that does the fixing.
  sox::default_umask::fix { $files: }
}
