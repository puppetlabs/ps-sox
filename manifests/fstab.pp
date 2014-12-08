# define options for various mounts
class sox::fstab (
  $fixit = $::sox_fix,
  $warn  = true,
) {
    if $fixit and $warn {
        notify {"${name}: Automatic fix not available, please fix manually":}
    }

    #  mount { '/dev/shm':
    #    dump    => '0',
    #    options => 'rw,nodev,noexec,nosuid',
    #    pass    => '0',
    #  }
    #
    #  mount { '/home':
    #    dump    => '1',
    #    options => 'rw,nodev',
    #    pass    => '2',
    #  }
    #
    #  mount { '/opt':
    #    dump    => '1',
    #    options => 'defaults',
    #    pass    => '2',
    #  }
    #
    #  mount { '/tmp':
    #    dump    => '1',
    #    options => 'rw,nodev,nosuid',
    #    pass    => '2',
    #  }
    #
    #  mount { '/var':
    #    dump    => '1',
    #    options => 'rw,nodev',
    #    pass    => '2',
    #  }
    #
    #  mount { '/var/log':
    #    dump    => '1',
    #    options => 'rw,nodev,noexec',
    #    pass    => '2',
    #  }
    #  #
    #
    #  exec { 'bind_tmp_var_tmp':
    #    command   => '/bin/mount --bind /tmp /var/tmp',
    #    unless    => '/bin/grep "^/tmp /var/tmp none rw,bind 0 0$" /etc/mtab',
    #    path      => $::path,
    #    logoutput => true,
    #    before    => Mount['/var/tmp'],
    #  }
    #
    #  mount { '/var/tmp':
    #    ensure  => defined,
    #    device  => '/tmp',
    #    fstype  => 'none',
    #    dump    => '0',
    #    options => 'bind',
    #    pass    => '0',
    #  }
    #
    #  file { '/etc/fstab':
    #    owner => 'root',
    #    group => 'root',
    #    mode  => '0444',
    #  }
}
