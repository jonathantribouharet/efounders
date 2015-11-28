class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	include CurrentUser
	include JT::Rails::Meta

	def require_access_to_room
		if @room.kicked_users.exists?(current_user)
			flash[:alert] = "You have been kicked of this room"

			if request.xhr?
				render :js => "window.location = '/'"
			else
				redirect_to root_url
			end
		end
	end

end
