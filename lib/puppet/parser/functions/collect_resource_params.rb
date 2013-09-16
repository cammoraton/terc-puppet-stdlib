# Collect all resources defined in the catalog of a certain type.
require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:collect_resource_params,
                                      :type => :rvalue,
                                      :doc => <<-'EOS'

EOS
) do |vals|
  
  
end