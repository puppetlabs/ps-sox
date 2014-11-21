Facter.add(:check_keyserv) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/default/keyserv'
      # Assume failure if not matched below
      result = 'Failed'
      File.open('/etc/default/keyserv','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /^ENABLE_NOBODY_KEYS=NO.*$/
            result = 'Passed'
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
