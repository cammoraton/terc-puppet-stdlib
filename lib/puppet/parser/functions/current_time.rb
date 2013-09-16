# Simple call out to Ruby's time function to retrieve the current system time.
# if you need precision this may be dangerous due to drift and/or unsynched masters in a 
# multiple master environment.
require 'puppet/parser/functions'
require 'time'

Puppet::Parser::Functions.newfunction(:curtime,
                                      :type => :rvalue,
                                      :doc => <<-'EOS'

EOS
) do |args|
  return Time.now()
end