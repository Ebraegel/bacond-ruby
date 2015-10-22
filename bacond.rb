#!/usr/bin/env ruby

require 'socket'
require 'optparse'

usage = "Usage: 
./bacon_server.rb  [-nh]  [-p port]
note: you should be root to use ports < 1024

"

class BaconServer

  @@default_meatlist = ["alcatra", "amet", "andouille", "bacon", "ball", "beef", "belly", "biltong", "boudin", "bresaola", \
  "brisket", "capicola", "chicken", "chop", "chuck", "corned", "cow", "cupim", "dolor", "doner", "drumstick", \
  "fatback", "filet", "flank", "frankfurter", "ground", "ham", "hamburger", "hock", "jerky", "jowl", "kevin", \
  "kielbasa", "kishka", "landjaeger", "leberkas", "loin", "meatball", "meatloaf", "mignon", "pancetta", \
  "pastrami", "picanha", "pig", "porchetta", "pork", "prosciutto", "ribeye", "ribs", "round", "rump", \
  "salami", "sausage", "shank", "shankle", "short", "shoulder", "sirloin", "spare", "steak", "strip", "swine", \
  "t-bone", "tail", "tenderloin", "tip", "tongue", "tri-tip", "turducken", "turkey", "venison"]

  def initialize(params = {})
    # default options will be overridden by anything in the params hash when merged
    options = {:meatlist => @@default_meatlist, :newline => false, :port => 47808}.merge(params)
    @meatlist = options[:meatlist]
    @newline = options[:newline]
    @port = options[:port]
    begin
    @server = TCPServer.new(@port)
    rescue TypeError => e
      puts "There was an error listening on port #{@port}."
      puts "Perhaps it is already in use, or you do not have permission to open it (you should be root if the port is < 1024)"
      exit
    end
  end # initialize

  def run_server
    loop do
      socket = @server.accept
      socket << @meatlist.sample
      socket << "\n" if @newline == true
      socket.close
    end # loop
  end # run_server

end # BaconServer

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = usage
  opts.on("-p", "--port port", Integer, "BaconServer's listen port.  Default is 47808 (0xBAC0).") { |port| options[:port] = port }
  opts.on("-n", "--newline", "Include a newline after each meat. Default is no newline.") { options[:newline] = true }
  opts.on('-h', '--help', "-?", 'Display this help text') do
    puts opts
    exit
  end
  opts.parse!
end

server = BaconServer.new(options)
server.run_server
