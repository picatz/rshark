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
            erb :feed
          end

          app.get '/capture' do
            redirect to('/') unless is_authenticated?
            iface = PacketFu::Utils.default_int
            unless session[:capture_file]
              session[:capture_file] = PacketFu::Capture.new
            end
            @cap = session[:capture_file]
            binding.pry
            erb :capture
          end

          app.post '/capture/filter' do
            redirect to('/') unless is_authenticated?
            # apply filter
            binding.pry
            @cap = session[:capture_file]
            erb :capture
          end



        end
      end
    end
  end
end
