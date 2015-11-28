class CreateRooms < ActiveRecord::Migration
	def change
		create_table :rooms do |t|
			t.belongs_to :user, null: false
			t.string :name, null: false
			t.timestamps null: false
		end
	end
end
