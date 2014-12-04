# == Class: sox
#
# Full description of class sox here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'sox':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Zack Smith <zack@puppetlabs.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class sox(
  $exclude_classes = [],
  $fix             = false,
) {

  validate_array($exclude_classes)

  $default_classes = $::osfamily ? {
      'RedHat' => [
          'sox::6000tcp',
          'sox::disable_rmmount',
          'sox::fstab',
          'sox::gdm',
          'sox::gui_login',
          'sox::keyserv',
          'sox::loginlog',
          'sox::root_login_console',
          'sox::sendmail',
          'sox::singleuser',
          'sox::su',
          'sox::sulog',
          'sox::syslog',
          'sox::user_policy',
          'sox::xfs',
      ],
  }

  $enabled_classes = difference($default_classes,$exclude_classes)

  include $enabled_classes

  # Generate a series of sox_ facts i.e. sox_xfs and set value to "enabled"
  # The check_* facts will conditionally confine themselves base on these sister facts
  sox::fact { $enabled_classes:
    ensure  => 'present',
    find    => 'sox::',
    replace => 'sox_',
    value   => 'enabled',
  }

  # Clean up any excluded facts
  sox::fact { $exclude_classes:
    ensure  => 'absent',
    find    => 'sox::',
    replace => 'sox_',
    value   => 'enabled',
  }

  # This fact controls the defaults for all the classes $fixit param
  sox::fact{ 'sox_fix':
    value => $fix,
  }

}
