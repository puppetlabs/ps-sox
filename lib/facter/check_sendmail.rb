Facter.add(:check_sendmail) do
  confine :sox_sendmail => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/mail/sendmail.cf'
      # Assume failure if not matched below
      result = 'Failed'
      File.open('/etc/mail/sendmail.cf','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched
          if line =~ /^O DaemonPortOptions=.*$/
            # If the address is set to correct value pass
            x,port,addr,name = line.match(/^(.*DaemonPortOptions=).*Port=(.*),.*Addr=(.*),.*Name=(MTA.*)$/).captures
            if addr == '127.0.0.1'
              result = 'Passed'
              break
            end
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
