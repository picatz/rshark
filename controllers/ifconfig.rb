module Sinatra
  module App
    module Controllers
      module Ifconfig 
        def self.registered(app)
          app.get '/ifconfig' do
            iface = PacketFu::Utils.default_int
            @config = PacketFu::Utils.ifconfig(iface)
            #binding.pry  
            erb :ifconfig
          end
        end
      end
    end
  end
end
