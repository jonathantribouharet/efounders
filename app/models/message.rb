class Message < ActiveRecord::Base

	belongs_to :room
	validates :room_id, presence: true

	belongs_to :user
	validates :user_id, presence: true

	has_attached_file :media, styles: lambda { |attachment| attachment.instance.processors }
	do_not_validate_attachment_file_type :media

	def media_is_image?
		self.media_content_type.match(/\Aimage\/.*\Z/) != nil
	end

	def processors
		if self.media_is_image?
			{ medium: '400x400#' }
		else
			{}
		end
	end

end
