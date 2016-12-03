module Sinatra
  module App
    module Controllers
      module Ifconfig 
        def self.registered(app)
          app.get '/ifconfig' do
            redirect to('/') unless is_authenticated? 
            @config = PacketFu::Utils.ifconfig
            erb :ifconfig
          end
        end
      end
    end
  end
end
