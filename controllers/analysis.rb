module Sinatra
  module App
    module Controllers
      module Analysis 
        def self.registered(app)

          app.get '/feed' do
            redirect to('/') unless is_authenticated?
            iface = PacketFu::Utils.default_int
            cap = PacketFu::Capture.new(:iface => iface)
            cap.start
            sleep 2
            cap.save
            @capture_sample = cap.array.sample(4)
            #packet_info = PacketFu::Packet.parse(cap.array.sample(4)[0])
            #binding.pry
            erb :feed
          end

          app.get '/capture' do
            redirect to('/') unless is_authenticated?
            binding.pry
            #erb :capture
          end

        end
      end
    end
  end
end