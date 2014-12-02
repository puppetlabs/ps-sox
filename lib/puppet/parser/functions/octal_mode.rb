# return fixed mode base on passed mode and umask
# $correct_mode = octal_mode('0777','0027')
module Puppet::Parser::Functions
  newfunction(:octal_mode, :type => :rvalue) do |args|
    mode  = args[0]
    umask = args[1]
    result = "%o" % mode - (mode & umask)
  end
end
