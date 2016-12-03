module Sinatra
  module App
    module Controllers
      module About 
        def self.registered(app)
          app.get '/about' do
            erb :about
          end
        end
      end
    end
  end
end
