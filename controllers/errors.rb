module Sinatra
	module App
		module Controllers
			module Errors
				def self.registered(app)
					app.error do
						halt 500, "Y U NO WORK?"
					end

					app.not_found do
						halt 404, "Whoops! That wasn't available."
					end
				end
			end
		end
	end
end
