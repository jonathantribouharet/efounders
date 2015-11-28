FACEBOOK_API_KEY = '788399267854953'
FACEBOOK_API_SECRET = '17c85364dd760496fc4697c4295189ca'

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, FACEBOOK_API_KEY, FACEBOOK_API_SECRET, image_size: 'large', secure_image_url: true, info_fields: 'name,email'
end
