class Room < ActiveRecord::Base

	has_many :messages, dependent: :destroy
	has_many :participants, -> { order('users.username ASC').uniq }, through: :messages, source: :user

	belongs_to :user
	validates :user_id, presence: true

	has_and_belongs_to_many :kicked_users, class_name: 'User'

	validates :name, presence: true

	scope :search_by_name, ->(q) { q.blank? || q.split(' ').size == 0 ? nil : where("LOWER(#{self.table_name}.name) LIKE LOWER(?)", '%' + q.gsub('%', ' ').gsub('_', ' ').split(' ').join('%') + '%') }

	def can_ban_user?(current_user, user)
		return false if !current_user || !user
		return false if current_user.id != self.user_id
		return false if current_user.id == user.id

		return true
	end

	def participants_not_banned
		kicked_user_ids = self.kicked_user_ids
		if kicked_user_ids.size > 0
			self.participants.where('users.id NOT IN (?)', kicked_user_ids)
		else
			self.participants
		end
	end

end
