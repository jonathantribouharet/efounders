FactoryGirl.create :user, email: 'eviljojo22@hotmail.com', password: 'eviljojo22@hotmail.com', is_admin: true
FactoryGirl.create :user, email: 'admin@admin.com', password: 'admin@admin.com', is_admin: true

10.times { FactoryGirl.create :user }
10.times { FactoryGirl.create :room, user: User.order('RANDOM()').first }
1000.times do
	message = FactoryGirl.build :message
	message.user = User.order('RANDOM()').first
	message.room = Room.order('RANDOM()').first
	message.save
end