FactoryGirl.define do
	factory :room do
		name { Faker::Commerce.product_name }
	end
end
