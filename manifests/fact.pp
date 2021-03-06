define sox::fact(
  $value,
  $ensure   = 'present',
  $find     = undef,
  $replace  = undef,
  $filename = $name,
  $key      = $name,
) {

  if $find and $replace {
    $fact_name = regsubst($key,$find,$replace)
  }
  else {
    $fact_name = $key
  }

  File {
    owner => 'pe-puppet',
    group => 'pe-puppet',
  }

  if ! defined(File['/etc/facter']) {
    file { '/etc/facter':
      ensure => directory,
    }
  }

  if ! defined(File['/etc/facter/facts.d']) {
    file { '/etc/facter/facts.d':
      ensure => directory,
    }
  }

  file { "/etc/facter/facts.d/${fact_name}.yaml":
    ensure  => $ensure,
    content => template("${module_name}/facts_d.erb"),
  }


}
