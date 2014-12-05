root_uid = 0
root_gid = 0
fix_ftpconfperms = []

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
      ftpconf = File.stat(file)
      if
        ( "%o" % ftpconf.mode ) == '100600' &&
        ftpconf.uid == root_uid &&
        ftpconf.gid == root_gid &&
        checks[file] = 'Passed'
      else
        fix_ftpconfperms << file
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

Facter.add(:fix_ftpconfperms) do
  setcode do
    fix_ftpconfperms.join(',')
  end
end
