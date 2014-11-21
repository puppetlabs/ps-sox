require 'augeas'
Facter.add(:check_user_policy) do
  confine :kernel => 'Linux'
  setcode do
    # Assume failure as file must exist with line to pass
    status = 'Failed'
    Augeas::open do |aug|
      aug.get('/files/etc/login.defs/PASS_MAX_DAYS') == '90' &&
      aug.get('/files/etc/login.defs/PASS_MIN_DAYS') == '7' &&
      aug.get('/files/etc/login.defs/PASS_MIN_LEN')  == '8' &&
      aug.get('/files/etc/login.defs/PASS_WARN_AGE') == '14' &&
      status = 'Passed'
    end
    status
  end
end
