failed_files = []
Facter.add(:check_fileperms) do
  confine :kernel => 'Linux'
  setcode do
    files = [
      '/var/log/wtmp',
      '/var/log/messages',
      '/var/log/secure',
      '/var/log/maillog',
      '/var/log/spooler',
      '/var/log/boot.log',
      '/var/log/cron',
    ]

    checks = {}
    files.each do |file|
      next unless File.exist?(file)
      if sprintf("%o", File.stat(file).mode) == '100600'
        checks[file] = 'Passed'
      else
        checks[file] = 'Failed'
        failed_files << file
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

Facter.add(:fix_fileperms) do
  confine :kernel => 'Linux'
  setcode do
    failed_files.join(',')
  end
end
