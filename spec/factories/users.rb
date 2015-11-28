FactoryGirl.define do
	factory :user do

		username { Faker::Name.name }
		email { Faker::Internet.email }
		password { Faker::Internet.email }

		media { Faker::Avatar.image }

	end
end
