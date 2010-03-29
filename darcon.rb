#
# Darcon - RCON ruby client
# by pH (Pedro Henrique Cavallieri Franceschi) - iBlogeek.com - 2006-2010 (C) - All Rights Reserved - @pedroh96 - pedrohfranceschi@gmail.com
#

require "rubygems"
require "steam/servers/source_server"
require "highline/import"

class Darcon
  
  def initialize(ip, port)
    $server = SourceServer.new(IPAddr.new(ip), port)
    $ip = ip
    $port = port
  end
  
  def is_online?
    begin
      $server.get_server_info
    rescue
      return false
    end
    return true
  end
  
  def ip
    return $ip
  end
  
  def port
    return $port
  end
  
  def rcon_auth(password)
    if $server.rcon_auth(password)
      return true
    else
      return false
    end
  end
  
  def rcon_exec(command)
    return $server.rcon_exec(command)
  end
  
end

def show_usage
  puts "darcon server_ip:server_port"
  puts "by pH"
end

unless ARGV[0]
  show_usage
  Process.exit
end

server = Darcon.new(ARGV[0].split(":")[0], ARGV[0].split(":")[1].to_i)

unless server.is_online?
  puts "Server is offline."
  Process.exit
end

puts "Darcon - by pH (Pedro Henrique Cavallieri Franceschi) - iBlogeek.com - 2006-2010 (C) - All Rights Reserved - @pedroh96 - pedrohfranceschi@gmail.com"
password = ask("#{server.ip}:#{server.port}'s RCON password: ") { |q| q.echo = false }

if server.rcon_auth(password)
  while true
    print "[#{server.ip}:#{server.port}]$ "
    command = $stdin.gets.chomp
    server.rcon_exec(command).split("\n").each do |line|
      unless line["rcon from"]
        puts line
      end
    end
  end
else
  puts "Wrong RCON password."
  Process.exit
end