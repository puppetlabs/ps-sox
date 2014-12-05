## Description:
##   This fact scans specified files and searches for lines that set a umask
##   that differs from our specified umask.  If any such lines are discovered,
##   this fact will report "Failed", meaning non-compliant.
##
## Caveats:
##   - If a file is sourced by one of the files we're checking, it will not
##     be checked.
##   - This does not evaluate conditional logic in the rc files. If umasks are
##     set based on some conditional logic, this fact will not account for
##     that.
##
## Reference:
##   http://www.stigviewer.com/stig/red_hat_enterprise_linux_5/2014-04-02/finding/V-808
##
## This constant should be set to the desired umask to search for. Any 'umask'
## line that isn't set to this will cause this fact to report 'Failed'
##

UMASK='022'

fix_umasks = []

Facter.add(:check_default_umask) do
  confine :sox_default_umask => 'enabled'
  setcode do

    ## This array contains the absolute path to any files that we want to check
    ## for umask settings.
    files = [
      '/etc/bashrc',
      '/etc/profile',
    ]

    result = 'Passed'

    files.each do |file|
      next unless File.exist?(file)
      File.open(file,'r') do |rcfile|
        rcfile.each_line do |line|
          ## Skip any comments in the file, including comments with leading
          ## whitespace.
          next if line =~ /^(\s+)?#.*$/

          ## If there's a 'umask' line that doesn't match our UMASK, fail
          if line =~ /(umask (?!#{UMASK}).*)/
            result = "Failed"
            fix_umasks << file
            break
          end
        end
      end
    end

    result
  end
end

Facter.add(:fix_default_umask) do
  confine :sox_default_umask => 'enabled'
  setcode do
    fix_umasks.join(',')
  end
end
