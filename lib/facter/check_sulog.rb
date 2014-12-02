Facter.add(:check_sulog) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/default/su'
      # Assume failure if not matched below
      check[0],check[1] = 'Failed','Failed'
      File.open('/etc/default/su','r') do |file|
        file.each_line do |line|
          # Skip any comments in the file
          next if line =~ /^#.*$/
          # If the line is matched break out and pass
          if line =~ /^SULOG=\/var\/adm\/sulog$/
            check[0] = 'Passed'
            break
          end
        end
      end
    su = File.stat('/etc/default/su')
    check[1] = 'Passed' if ( "%o" % su.mode ) == '100600'
    'Failed' if check.include?('Failed')
    else
      # If file does not exist we fail the test
      'Failed'
    end
  end
end
