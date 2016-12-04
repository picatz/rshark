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

          app.get '/statistics' do
            redirect to('/') unless is_authenticated?
            #binding.pry
            erb :statistics
          end

          app.post '/statistics' do
            redirect to('/') unless is_authenticated?
            if params[:file]
              if File.extname(params[:file][:filename]).downcase == ".pcap"
                @stats = Hash.new(0) 
                PacketFu::PcapFile.read_packets(params[:file][:tempfile]) do |packet|
                  @stats[packet.proto.last.to_sym] += 1
                end
              else
                @failed = "Tried to upload a non-pcap file."
              end
            else
              @failed = "No file given to upload."
            end
            #binding.pry
            erb :statistics
          end

          app.get '/capture' do
            redirect to('/') unless is_authenticated?
            iface = PacketFu::Utils.default_int
            unless session[:capture_file]
              iface = PacketFu::Utils.default_int
              session[:capture_file] = PacketFu::Capture.new(:iface => iface)
            end
            erb :capture
          end

          app.post '/capture/filter' do
            redirect to('/') unless is_authenticated?
            binding.pry
            unless params["iface"].empty?
              begin
                session[:capture_file] = PacketFu::Capture.new(:iface => params["iface"])
              rescue
                @failed = "Unable to set network face."
              end
            end

            unless params["bpf"].empty?
              begin
                binding.pry
                session[:capture_file].bpf(:filter => params["bpf"])
              rescue
                binding.pry
                @failed = "Invalid Berkely Packet Filter Syntax"
              end
            end
            binding.pry
            erb :capture
          end
        end

      end
    end
  end
end
