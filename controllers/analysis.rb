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
            sleep 1
            cap.save
            @capture_sample = cap.array
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
                @protocol_stats = Hash.new(0) 
                @mac_addr_stats = Hash.new(0) 
                @ip_addr_stats  = Hash.new(0) 
                PacketFu::PcapFile.read_packets(params[:file][:tempfile]) do |packet|
                  @protocol_stats[packet.proto.last.to_sym] += 1
                  begin
                    @mac_addr_stats[packet.eth_daddr] += 1
                    @mac_addr_stats[packet.eth_saddr] += 1
                  rescue
                    # :(
                  end
                  begin
                    @ip_addr_stats[packet.ip_saddr]   += 1 
                    @ip_addr_stats[packet.ip_daddr]   += 1
                  rescue
                    # :(
                  end
                end
              else
                @failed = "Tried to upload a non-pcap file."
              end
            else
              @failed = "No file given to upload."
            end
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
