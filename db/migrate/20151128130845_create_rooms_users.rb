class CreateRoomsUsers < ActiveRecord::Migration
	def change
		create_table :rooms_users do |t|
			t.belongs_to :user, null: false
			t.belongs_to :room, null: false
		end
	end
end
