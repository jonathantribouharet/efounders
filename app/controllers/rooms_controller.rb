class RoomsController < ApplicationController

	before_action :require_user

	def index
		@room = Room.new
		
		if !params[:name].blank?
			@rooms = Room.search_by_name(params[:name]).limit(8).all
		else
			@rooms = []
		end
	end

	def show
		@room = Room.find(params[:id])
		@messages = @room.messages.includes(:user).order('id DESC').limit(10).to_a.reverse

		require_access_to_room
	end

	def create
		room = current_user.rooms.new(room_params)
		if room.save
			redirect_to room_url(room)
		else
			redirect_to rooms_url
		end
	end

	def ban
		@room = current_user.rooms.find(params[:id])
		user = User.find(params[:user_id])
		@room.kicked_users << user if @room.can_ban_user?(current_user, user)

		redirect_to room_url(@room) if !request.xhr?
	end

private

	def room_params
		params.require(:room).permit(:name)
	end

end