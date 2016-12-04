#!/usr/bin/env ruby 

# Pry for Debugging
require 'pry'

# Require Gems
require 'sinatra/base'
require 'thin'
require 'logger'
require 'tilt/erubis'
require 'packetfu'
require 'network_interface'

# Require Custom Application Files
require_relative 'application/user'

# Require Custom Application Controllers
require_relative 'controllers/index'
require_relative 'controllers/about'
require_relative 'controllers/feed'
require_relative 'controllers/utilities'
require_relative 'controllers/sessions'
require_relative 'controllers/errors'

# Require Application Helpers
require_relative 'helpers/application'

class Application < Sinatra::Base 

  # Configure Application Logging

  # Logging options for the application.
  ::Logger.class_eval { alias :write :'<<' }

  # setup logging directory
  unless Dir.exists?(::File.join(::File.dirname(::File.expand_path(__FILE__)),'log'))
    Dir.mkdir (::File.join(::File.dirname(::File.expand_path(__FILE__)),'log'))
  end

  # setup access logging
  access_log = ::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','access.log')
  unless File.exists?(access_log)
    File.open(access_log, "w") {}
  end
  access_logger = ::Logger.new(access_log)

  # setup error logging
  error_log = ::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','error.log')
  unless File.exists?(error_log)
    File.open(error_log, "w") {}
  end
  error_logger = ::Logger.new(error_log)

  before do
    redirect to('/') unless request.ip == "127.0.0.1" 
    #env["rack.errors"] = error_logger
    headers["picat"] = "loves ruby"
  end

  configure do
    enable :sessions
    enable :logging
    set :environment, :production
    set :bind, '0.0.0.0'
    #set :port, 80
    set :server, :thin
    #set :erb, :escape_html => true
    set :root, File.dirname(__FILE__)
    if server.respond_to? :threaded=
      server.threaded = settings.threaded
    end
    #use ::Rack::CommonLogger, access_logger
    helpers  Sinatra::App::ApplicationHelpers
    register Sinatra::App::Controllers::Index
    register Sinatra::App::Controllers::About
    register Sinatra::App::Controllers::Feed
    register Sinatra::App::Controllers::Utilities
    register Sinatra::App::Controllers::Sessions
    register Sinatra::App::Controllers::Errors
  end 

  def self.run!
    super do |server|
      # print out that sharky shark ( if we haz him/her )!
      File.readlines("sharky.txt").each {|line| puts line} if File.file?("sharky.txt")
      # stuff before server is started
    end
  end

end

if __FILE__ == $0
  Application.run!
end

