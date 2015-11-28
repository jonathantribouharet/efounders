class User < ActiveRecord::Base

	include UserAuthentication

	has_many :messages, dependent: :destroy
	has_many :rooms, dependent: :destroy
	
	has_attached_file :media, styles: { thumb: '80x80#' }
	validates_attachment :media, content_type: { content_type: /\Aimage\/.*\Z/ }

	before_create :set_last_activity_at

	def set_last_activity_at
		self.last_activity_at = Time.now
	end

	def is_active?
		(Time.now - self.last_activity_at) <= (60 * 5)
	end

end
