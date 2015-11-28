class CreateMessages < ActiveRecord::Migration
	def change
		create_table :messages do |t|
			t.belongs_to :room, null: false
			t.belongs_to :user, null: false
			
			t.text :content

			t.attachment :media
			t.string :media_fingerprint

			t.timestamps null: false
		end
	end
end
