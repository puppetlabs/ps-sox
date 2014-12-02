ROOT_UID = 0
ROOT_GID = 0
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
        ftpconf.uid == ROOT_UID &&
        ftpconf.gid == ROOT_GID &&
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
