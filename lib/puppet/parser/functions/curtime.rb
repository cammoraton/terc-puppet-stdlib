# Simple call out to Ruby's time function to retrieve the current system time.
# if you need precision this may be dangerous due to drift and/or unsynched masters in a 
# multiple master environment.
require 'puppet/parser/functions'
require 'time'
require 'socket'

Puppet::Parser::Functions.newfunction(:curtime,
                                      :type => :rvalue,
                                      :doc => <<-'EOS'
  Query the specified ntp server(or pool) for a time, or if no server is specified then call out to
  ruby's time function.
EOS
) do |args|
  ntp_server = args
  return Time.now() unless ntp_server # Simple call out to Time.now()

  # Otherwise we need to set up a socket and reach out and touch someone, yo
  sock = UDPSocket.new
  packet = [0b11100011, 0, 6, 0xEC, 0, 49, 0x4E, 49, 52,0,0,0,0].pack("C4QC4Q4")
  
  sock.send packet, 0, ntp_server, 123
  response = sock.recv(48)
  toss, time = response.unpack("A40N")
  
  return Time.at(time - 2208988800)
end