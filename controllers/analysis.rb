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
            @capture_sample = cap.array
            erb :feed
          end

          app.get '/statistics' do
            redirect to('/') unless is_authenticated?
            erb :statistics
          end

          app.post '/statistics' do
            redirect to('/') unless is_authenticated?
            if params[:file]
              if File.extname(params[:file][:filename]).downcase == ".pcap"
                @protocol_stats  = Hash.new(0) 
                @mac_addr_stats  = Hash.new(0) 
                @eth_proto_stats = Hash.new(0) 
                @ip_addr_stats   = Hash.new(0) 
                @ip_ttl_stats    = Hash.new(0) 
                PacketFu::PcapFile.read_packets(params[:file][:tempfile]) do |packet|
                  @protocol_stats[packet.proto.last.to_sym] += 1
                  begin
                    @mac_addr_stats[packet.eth_daddr] += 1
                    @mac_addr_stats[packet.eth_saddr] += 1
                    @eth_proto_stats[packet.eth_proto_readable] += 1
                  rescue
                    # :(
                  end
                  begin
                    @ip_addr_stats[packet.ip_saddr] += 1 
                    @ip_addr_stats[packet.ip_daddr] += 1
                    @ip_ttl_stats[packet.ip_sum]    += 1
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
            erb :capture
          end

          app.post '/capture' do
            redirect to('/') unless is_authenticated?
            binding.pry
            # params.keys.each { |key| params[key].empty? ? params[key] = false : true }
            # iface   = params['iface']   || PacketFu::Utils.default_int
            # snaplen = params['snaplen'] || 65535
            # capture = PCAPRUB::Pcap.open_live(iface, snaplen, true, 0)
            # capture.setfilter(params['bpf'])  if params['bpf']
            # @parsed_packets = []
            # if params['cap_limit']
            #   params['cap_limit'].to_i.times do
            #     binding.pry
            #     pkt = capture.next()
            #     @parsed_packets << PacketFu::Packet.parse(pkt)
            #   end
            # else        
            #   40.times do 
            #     pkt = capture.next()
            #     @parsed_packets << PacketFu::Packet.parse(pkt)
            #   end
            # end
            # binding.pry
            erb :capture
          end

          app.get '/capturing' do 
            @cap = session[:capture_file]
            erb :capturing
          end

        end
      end
    end
  end
end
