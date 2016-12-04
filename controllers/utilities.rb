module Sinatra
  module App
    module Controllers
      module Utilities 
        def self.registered(app)
          
          app.get '/ifconfig' do
            redirect to('/') unless is_authenticated? 
            @config = PacketFu::Utils.ifconfig
            erb :ifconfig
          end

          app.get '/network_interfaces' do
            redirect to('/') unless is_authenticated? 
            @network_interface_names = NetworkInterface.interfaces
            @network_interface_info = []
            @network_interface_names.each do |interface_name|
              info = {}
              interface_info = NetworkInterface.addresses(interface_name)
              interface_info.keys.each do |key|
                info[:mac_addr] = interface_info[key] if key == 18
                info[:ipv4_addr] = interface_info[key] if key == 2
                info[:ipv6_addr] = interface_info[key] if key == 30
              end
              @network_interface_info << {:name => interface_name, :info => info}
            end
            erb :network_interfaces
          end

          app.get '/pingable' do
            redirect to('/') unless is_authenticated? 
            erb :ping_tool
          end
          
          app.post '/pingable' do
            redirect to('/') unless is_authenticated? 
            @stats = Hash.new(0)
            10.times do
              @stats[:Yes] += 1 if Net::Ping::External.new(params['ip']).ping?
              @stats[:No] += 1  unless Net::Ping::External.new(params['ip']).ping?
            end
            erb :ping_tool
          end

        end
      end
    end
  end
end
