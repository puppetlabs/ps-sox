Facter.add(:check_disable_rmmount) do
  confine :sox_disable_rmmount => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/auto.misc'
      # Assume failure if not matched below
      result = 'Passed'
      File.open('/etc/auto.misc','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /.*\/dev\/cdrom.*$/
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
