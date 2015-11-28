ActiveAdmin.register User do

	actions :index

	filter :email
	filter :username
	filter :created_at

	index do
		column :id
		column :email
		column :username
		column :last_login_at
		column :login_count
		column 'Rooms Count' do |user|
			user.rooms.count
		end
		column 'Messages Count' do |user|
			user.messages.count
		end
		column :created_at

		actions do |user|
			link_to('Connect', connect_admin_user_path(user.id), class: "member_link")
		end
	end

	member_action :connect, method: :get do
		session[:user_id] = params[:id]
		redirect_to root_url
	end

end
