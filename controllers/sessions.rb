module Sinatra
  module App
    module Controllers
      module Sessions
        def self.registered(app)

          app.get '/login' do
            erb :login
          end

          app.post '/login' do
            session[:user] = User.new
            erb :index
          end

          app.get '/logout' do
            session.delete(:user)
            erb :index
          end
        end
      end
    end
  end
end
