require 'securerandom'

class User
  attr_accessor :username, :password, :id, :email, :real_name
	
	# initialize() handles the create of a new object of a User
	# class and can optionally also create the attributes associated
	# for that new user.
	def initialize(opts={})
		setup(opts) if opts[:username] or opts[:password]
	end

  # setup() sets up a new user and all the required information
  # that we will want to know about a user.
  #
  # == Example
  #
  #  # Typical use to create a new user
  #  user = User.new
  #  user.setup(:username => "picat", :password => "easyas123" )
  #  user.username
	#  # => "picat"
	#  user.password
	#  # => "easyas123"
  #
  def setup(opts={})
		if meets_restrictions?(opts)
			if require_user_pass(opts)
 				@username  = opts[:username]
				@password  = opts[:password]
				@id        = opts[:id]        || SecureRandom.uuid
				@email     = opts[:email]     || false
				@real_name = opts[:real_name] || false
			end
		end
		true
	end

	private 

	# require_user_pass() helps ensure that a user has both a username
	# and a password associated with it when doing automatic setup
	# within the context of this User class.
	def require_user_pass(opts={})
		raise "Username required to create a user!" unless opts[:username]
		raise "Password required to create a user!" unless opts[:password]
		true
	end
	
	# meets_restrictions?() helps ensure that input within the context of this class
	# is at least attempted to be santized if being user unwisely and 
	# simpyl trusting user input. 
	def meets_restrictions?(opts={}, restriction_file=false)
		if restriction_file
			raise "Unable to open custom restriction file" unless File.readable?(restriction_file)
			restrictions = YAML.load_file(restriction_file) || false
		else
			# restriction values can be set to false to turn them off
			restrictions = { :username => /\A[a-z0-9\-_]+\z/i,  
											 :password => false, 
											 :email => /\w+\d?@emich.edu\b/,
											 :real_name => /([A-z]+\s{0,1}){1,3}/
										 }
		end
		# ensure restrictions are set to match to, or raise an error
		if restrictions
			opts.keys.each do |key|
				if restrictions[key]
					unless opts[key] =~ restrictions[key]
						raise "Failed to meet the #{key.to_s} restriction!"
					end
				end
			end
		else
			raise "No restrictions set to be able to match restrictions!"
		end
		true
	end

end
