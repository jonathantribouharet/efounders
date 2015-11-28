class MessagesController < ApplicationController

	before_action :require_user
	before_action :find_room
	before_action :require_access_to_room

	def index
		@messages = @room.messages.includes(:user).order('id DESC').limit(10)
		@messages = @messages.where('id > ?', params[:last_message_id]) if !params[:last_message_id].blank?
		@messages = @messages.to_a.reverse
	end

	def create
		@message = current_user.messages.new(message_params)
		@message.room = @room

		@message.save

		if !request.xhr?
			if @message.persisted?
				redirect_to room_url(@room) 
			else
				flash[:alert] = "Cannot save your message"
				redirect_to room_url(@room)
			end
		end
	end

private

	def find_room
		@room = Room.find(params[:room_id])
	end

	def message_params
		params.require(:message).permit(:content, :media)
	end

end