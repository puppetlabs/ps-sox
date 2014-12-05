require 'augeas'

# We'll populate this with non-compliant files
fix_user_policy = []

Facter.add(:check_user_policy) do
  confine :sox_user_policy => 'enabled'
  confine :kernel   => 'Linux'
  confine :likewise => 'missing'
  setcode do
    check = []
    # Assume failure as file must exist with line to pass
    status = 'Failed'
    check[0],check[1],check[2] = 'Failed','Failed','Failed'
    Augeas::open do |aug|
      # Check for pol1
      aug.context = '/files/etc/login.defs'
      if
        aug.get('PASS_MAX_DAYS') == '90' &&
        aug.get('PASS_MIN_DAYS') == '7'  &&
        aug.get('PASS_MIN_LEN')  == '8'  &&
        aug.get('PASS_WARN_AGE') == '14'
        check[0] = 'Passed'
      else
        fix_user_policy << '/etc/login.defs'
      end

      # Check for pol2
      aug.context = '/files/etc/pam.d/system-auth'
      aug.context = "#{aug.context}/*[type = 'auth'][control = 'sufficient'][module = 'pam_unix.so']"
      aug.context = "#{aug.context}[argument[1] = 'nullok'][argument[2] = 'try_first_pass']"
      if aug.exists(aug.context)
        check[1] = 'Passed'
      else
        fix_user_policy << '/etc/pam.d/system-auth'
      end

      # Check for pol3
      [
        '/etc/pam.d/sshd',
        '/etc/pam.d/vsftpd',
        '/etc/pam.d/login'
      ].each do |pamfile|
        aug.context = "/files/#{pamfile}"
        aug.context = "#{aug.context}/*[type = 'auth'][control = 'required'][module = 'pam_tally2.so']"
        aug.context = "#{aug.context}[argument[1] = 'deny=3'][argument[2] = 'onerr=fail']"
        check[2] = 'Passed' if aug.exists(aug.context)
        if aug.exists(aug.context)
          check[2] = 'Passed'
        else
          fix_user_policy << pamfile
        end
      end

      if check.include?('Failed')
        status = 'Failed'
      else
        status = 'Passed'
      end
    end
    status
  end
end

Facter.add(:fix_user_policy) do
  confine :sox_user_policy => 'enabled'
  confine :kernel   => 'Linux'
  confine :likewise => 'missing'
  setcode do
    fix_user_policy.join(',')
  end
end
