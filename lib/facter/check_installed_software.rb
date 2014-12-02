Facter.add(:check_installed_software) do
  confine :kernel => 'Linux'
  setcode do

    ## Array of packages to check if installed via rpm
    packages = [
      'sudo',
      'tcp_wrappers',
    ]

    checks = {}
    packages.each do |package|
      ## Check the package state with 'rpm'
      if system("/bin/rpm -q #{package} > /dev/null 2>&1")
        checks[package] = 'Passed'
      else
        checks[package] = 'Failed'
      end
    end

    ## Return 'failed' if any of the packages are not installed
    if checks.detect {|k,v| v == 'Failed'}
      'Failed'
    else
      'Passed'
    end

  end
end
