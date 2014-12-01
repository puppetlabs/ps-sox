require 'augeas'
Facter.add(:check_user_policy) do
  confine :kernel   => 'Linux'
  confine :likewise => 'missing'
  setcode do
    # Assume failure as file must exist with line to pass
    check[0],check[1],check[2] = 'Failed','Failed','Failed'
    Augeas::open do |aug|
      # Check for pol1
      aug.context = '/files/etc/login.defs'
      aug.get('PASS_MAX_DAYS') == '90' &&
      aug.get('PASS_MIN_DAYS') == '7'  &&
      aug.get('PASS_MIN_LEN')  == '8'  &&
      aug.get('PASS_WARN_AGE') == '14' &&
      check[0] = 'Passed'

      # Check for pol2
      aug.context = '/files/etc/pam.d/system-auth'
      aug.context = "#{aug.context}/*[type = 'auth'][control = 'sufficient'][module = 'pam_unix.so']"
      aug.exists("[argument[1] = 'nullok'][argument[2] = 'try_first_pass']") &&
      check[1] = 'Passed'

      # Check for pol3
      [
         '/etc/pam.d/sshd',
         '/etc/pam.d/vsftpd',
         '/etc/pam.d/login'
       ].each do |pamfile|
         aug.context = "/files/#{pamfile}"
         aug.context = "#{aug.context}/*[type = 'auth'][control = 'required'][module = 'pam_tally2.so']"
         aug.exists("[argument[1] = 'deny=3'][argument[2] = 'onerr=fail']") &&
         check[2] == 'Passed'
      end
      status = 'Failed' if check.include?('Failed')
    end
    status
  end
end
