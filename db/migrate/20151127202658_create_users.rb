class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|

			t.string :username
			t.string :email
			t.string :password_digest
			
			t.string :password_token

			t.boolean :have_social_account, null: false, default: false

			t.attachment :media
			t.string :media_fingerprint

			t.datetime :last_login_at
			t.string :last_login_remote_ip
			t.integer :login_count, null: false, default: 0

			t.datetime :last_activity_at, null: false

			t.boolean :is_admin, null: false, default: false

			t.timestamps null: false
		end
	end
end
