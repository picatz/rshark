module Sinatra
	module App
		module ApplicationHelpers

			# is_authenticated?() checks if a user is authenticated
			# by checking if they have a user (class/object) is associated 
			# with the session or not.
			#
			# == Example
			#
			#  # Typical use case if a user is logged in
			#  is_authenticated?
			#  => true
			#
			#  # Typical use case if a user isn't logged in
			#  is_authenticated?
			#  => false
			#
			def is_authenticated?
				return !!session[:user]
			end

		end
	end
end
