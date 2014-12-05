Facter.add(:check_gdm) do
  confine :sox_gdm => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/X11/gdm/gdm.conf'
      # Assume failure if not matched below
      result = 'Failed'
      File.open('/etc/X11/gdm/gdm.conf','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /^AllowRoot=false.*$/
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
