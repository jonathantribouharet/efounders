module UserAuthentication
	extend ActiveSupport::Concern

	included do

		has_many :social_accounts, dependent: :destroy

		tokenize :password_token

		validates :username, presence: true
		validates :email, email_format: true, uniqueness: { case_sensitive: false }

		with_options if: Proc.new {|u| !u.have_social_account? } do |u|

			has_secure_password(validations: false)
			validates :email, presence: true

		end
		
		before_save :downcase_email

		scope :search_by_email, ->(email) { where(email: email.to_s.downcase) }
		scope :search_by_email_for_authentication, ->(email) { search_by_email(email).where('password_digest IS NOT NULL') }

	end

	class_methods do

		def authenticate(email, password)
			self.search_by_email_for_authentication(email).first.try(:authenticate, password)
		end

		def create_or_update_from_auth_hash(auth_hash)
			logger.info auth_hash.inspect

			expires_at = nil
			expires_at = Time.at(auth_hash['credentials']['expires_at']) if auth_hash['credentials']['expires_at']

			# Search existing account
			account = SocialAccount.where(provider_name: auth_hash['provider']).where(provider_uid: auth_hash['uid'].to_s).first
			if account
				account.token = auth_hash['credentials']['token']
				account.refresh_token = auth_hash['credentials']['refresh_token']
				account.expires_at = expires_at
				account.save!

				return account.user
			end
			
			email = auth_hash['info']['email'].to_s.downcase
			user = self.find_with_email_or_create_with_auth_hash(email, auth_hash)

			user.social_accounts.create!(
				provider_name: auth_hash['provider'],
				provider_uid: auth_hash['uid'].to_s,
				token: auth_hash['credentials']['token'],
				refresh_token: auth_hash['credentials']['refresh_token'],
				expires_at: expires_at,
			)

			user
		end

		def find_with_email_or_create_with_auth_hash(email, auth_hash)
			user = User.search_by_email(email).first if !email.blank?
			
			if user 
				user.media = auth_hash['info']['image'] if user.media_file_name.blank?
				user.username = auth_hash['info']['name']
				user.have_social_account = true

				user.save
			elsif !user
				user = User.create!({
					email: email,
					username: auth_hash['info']['name'],
					media: auth_hash['info']['image'],
					have_social_account: true
				})
			end

			user
		end

	end

	def downcase_email
		self.email.downcase! if self.email
	end

	def increment_login_stats!(remote_ip)
		attributes = {
			last_login_at: Time.now,
			last_login_remote_ip: remote_ip,
			login_count: self.login_count + 1
		}

		self.update_columns(attributes)
	end

end
