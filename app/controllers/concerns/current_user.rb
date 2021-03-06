module CurrentUser
	extend ActiveSupport::Concern

	included do
		helper_method :current_user
	end

	def set_current_user(user)
		session[:user_id] = user.id
		user.increment_login_stats!(request.remote_ip)
	end

	def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
		@current_user.update_column(:last_activity_at, Time.now) if @current_user
		@current_user
	end

	def store_location
		session[:return_to] = request.fullpath if request.get? && !request.xhr?
	end

	def require_user
		if !current_user
			store_location
			redirect_to login_url
			return false
		end
		true
	end

	def require_admin_user
		return true if Rails.env.development?
		
		return false if !require_user

		if !current_user.is_admin?
			flash[:alert] = "You don't have the rights"
			redirect_to root_url
			return false
		end
		true
	end
	
	def require_no_user
		if current_user
			redirect_to root_url
			return false
		end
		true
	end

	def redirect_back_or_default(default_url)
		redirect_to session[:return_to] || default_url
		session[:return_to] = nil
	end

end