Facter.add(:check_ftpconfperms) do
  confine :kernel => 'Linux'
  confine :osfamily => 'RedHat'
  confine :operatingsystemmajrelease => ['2','4','5','6','7']

  setcode do
    files = [
      '/etc/xinetd.d/wu-ftpd',
      '/etc/xinetd.d/gssftp',
      '/etc/vsftpd/vsftpd.conf',
    ]

    checks = {}
    files.each do |file|
      next unless File.exist?(file)
      if
        sprintf("%o", File.stat(file).mode) == '100600' &&
        File.stat(file).uid == 0 &&
        File.stat(file).gid == 0 &&
        checks[file] = 'Passed'
      else
        checks[file] = 'Failed'
      end
    end
    # Return the first failed check and fail or pass if not found
    if checks.detect {|k,v| v == 'Failed'}
      'Failed'
    else
      'Passed'
    end
  end
end
