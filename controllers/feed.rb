module Sinatra
  module App
    module Controllers
      module Feed 
        def self.registered(app)
          app.get '/feed' do
            binding.pry
            iface = PacketFu::Utils.default_int
            
            erb :feed
          end
        end
      end
    end
  end
end
