# Collect all resources defined in the catalog of a certain type.
require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:collect_resource_params,
                                      :type => :rvalue,
                                      :doc => <<-'EOS'
Takes a resource reference and an optional hash of attributes.

Returns true if a resource with the specified attributes has already been added
to the catalog, and false otherwise.

    user { 'dan':
      ensure => present,
    }

    if ! defined_with_params(User[dan], {'ensure' => 'present' }) {
      user { 'dan': ensure => present, }
    }
EOS
) do |vals|
  
  
end