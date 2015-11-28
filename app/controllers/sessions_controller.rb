class SessionsController < ApplicationController

	before_action :require_no_user, except: [:destroy]
	
	def new
	end

	def create
		if auth_hash
			user = User.create_or_update_from_auth_hash(auth_hash)
		else
			user = User.authenticate(params[:email], params[:password])
		end

		if user
			set_current_user(user)
			redirect_to root_url
		else
			flash[:alert] = "Invalid login"
			render :new
		end
	end
	
	def failure
		redirect_to root_url
	end

	def destroy
		reset_session
		redirect_to root_url
	end	

protected

	def auth_hash
		request.env['omniauth.auth']
	end

end
