Facter.add(:check_root_login_console) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/securetty'
      # Assume failure if not matched below
      result = 'Passed'
      File.open('/etc/securetty','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /^(ttyp|pts).*$/
            result = 'Failed'
            break
          end
        end
      end
      result
    else
      # If file does not exist we pass the test
      'Passed'
    end
  end
end
