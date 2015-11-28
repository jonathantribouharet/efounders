class CreateSocialAccounts < ActiveRecord::Migration
	def change
		create_table :social_accounts do |t|
			
			t.belongs_to :user, null: false

			t.string :provider_name, null: false
			t.string :provider_uid, null: false

			t.string :token
			t.string :refresh_token
			t.datetime :expires_at
			
			t.timestamps null: false
		end
		add_index :social_accounts, [:provider_name, :provider_uid], unique: true
	end
end
