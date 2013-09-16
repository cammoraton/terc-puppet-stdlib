# Collect all resources of a given type and return a hash of their names and parameters
require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:collect_resources_with_params,
                                      :type => :rvalue,
                                      :doc => <<-'EOS'
  Collects all resources of a given type and returns a hash containing their names and parameters 
  in the format $resource_name => { $params }
  
  EXAMPLE:
  define resource($foo = 'blah') { }
  
  class klass { resource { 'test': foo => 'bar' }
                resource { 'another_resource': foo => 'another_value' } }
    
  class another_class { $resources = collect_resource_with_params('resource') }
    
  $resources should equal { 'test' => { 'foo' => 'bar' }, 
                            'another_resource' => { 'foo' => 'another_value'} }
EOS
) do |args|
  resource_type = args
  retval = Hash.new  # I think this is clearer than {}
  type = Puppet::Resource.new(resource_type, "whatever").type # Canonicalize the type
  
  # Map everything in the compiler.  Note that this will catch exported resources.
  results = self.compiler.resources.find_all { |a| a.type == type } 
  
  unless results.nil? or results.empty?
    # Map our results and add in virtual/exported from the resource
    results.map{ |res| { res.name => res.to_hash.merge(
                         { :virtual => res.virtual, :exported => res.exported }) } }.each do |resource|
      retval.merge(resource)
    end
  end
  return retval
end