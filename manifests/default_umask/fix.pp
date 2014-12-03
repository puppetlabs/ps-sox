define sox::default_umask::fix (
  $file  = $title,
  $umask = '002',
) {
  validate_absolute_path($file)
  validate_re($umask, '\d{3}', 'umask must be 3 digits')

  ## How do we replace things on each platform? GNU sed does inplace
  ## replacement with -i with no arguments.  BSD sed does inplace replacement
  ## with -i and an argument ('' if replacing in the same file).
  ## Apparently, Solaris' sed doesn't have an "inplace" replacement, so another
  ## method would need to be used.
  ##
  ## file_line will not work here, as we're potentially matching several lines
  ## in a specified file.
  case $kernel {
    'Linux': {
      exec { "Specify umask ${umask} in ${file}":
        command => "sed -i 's/umask [0-9]\\{3\\}/umask ${umask}/g' ${file}",
        onlyif  => "egrep -v '^(\\s+)?#' ${file} | grep -v 'umask ${umask}' | grep -q umask",
        path    => ['/bin','/usr/bin'],
      }
    }
    default: {
      fail("Not supported on ${kernel}.")
    }
  }
}
