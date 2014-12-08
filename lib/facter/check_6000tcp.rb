Facter.add(:check_6000tcp) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/X11/xdm/Xservers'
      # Assume failure if not matched below
      result = 'Failed'
      File.open('/etc/X11/xdm/Xservers','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /\/usr\/X11R6\/bin\/X.*-nolisten tcp.*/
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
