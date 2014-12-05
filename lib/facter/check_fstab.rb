
require 'augeas'

# Helper method to search the matching filesystem  in fstab for the option
def match_option?(params)
  checks = {}
  Augeas::open do |aug|
    # Build the regex i.e. /files/etc/fstab/*[vfstype=~ regexp('^(ext3|ext2)$')
    regex = "^(#{params[:values].join('|')})$"
    matches = aug.match("/files/etc/fstab/*[#{params[:key]}=~ regexp('#{regex}')]")
    unless matches.empty?
      matches.each do |match|
        aug.context = match
        # Skip over any excluded files from our parms
        if params[:excluded]
          next if params[:excluded].include? aug.get('file')
        end

        # Check for single option args (defaults) or multi i.e. (gid=5)
        options = aug.match('opt[*]|opt')

        # Loop through the options looking for the correct value
        options.each do |option|
          params[:required].each do |required|
            if aug.get(option) == required
                checks["#{option}:#{required}"] = 'Passed'
            else
                checks["#{option}:#{required}"] = 'Failed'
            end
          end
        end
      end
    end
  end
  # If we have been given a default then return that otherwise true
  result = params[:default] || true

  # Return false if any of the checks were failed
  if checks.detect {|k,v| v == 'Failed'}
    result = false
  end
  result
end

Facter.add(:check_fstab_ndev) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    params = {
      :key      => 'vfstype',
      :values   => ['ext3','ext2'],
      :required => ['nodev'],
      :excluded => ['/','/boot']
    }
    # Return 'Failed' if any of the checks were failed
    if match_option?(params)
      'Passed'
    else
      'Failed'
    end
  end
end

Facter.add(:check_fstab_nsuid) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    params = {
      :key      => 'file',
      :values   => ['.*\/cdrom','.*\/floppy'],
      :required => ['nodevices','nodevices'],
    }
    # Return 'Failed' if any of the checks were failed
    if match_option?(params)
      'Passed'
    else
      'Failed'
    end
  end
end

Facter.add(:check_fstab_ro_mnt) do
  confine :sox_network => 'enabled'
  confine :kernel => 'Linux'
  setcode do
    # We default to false here as this entry is required even if its not matched
    params = {
      :key      => 'file',
      :values   => ['/usr'],
      :required => ['ro'],
      :default  => false,
    }
    # Return 'Failed' if any of the checks were failed or our default
    if match_option?(params)
      'Passed'
    else
      'Failed'
    end
  end
end
