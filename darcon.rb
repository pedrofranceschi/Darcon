require "rubygems"
require "steam/servers/source_server"

begin
  server = SourceServer.new(IPAddr.new(data.server_ip), data.server_port.to_i)
  info = server.get_server_info
rescue
  puts "Server is offline."
end
if server.rcon_auth(sv.rcon_password)