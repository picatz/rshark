module Sinatra
  module App
    module Controllers
      module Index
        def self.registered(app)

          # This specifies the main route of out application.
          app.get '/' do
            erb :index
          end

        end
      end
    end
  end
end
