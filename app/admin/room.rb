ActiveAdmin.register Room do

	actions :index

	filter :name
	filter :created_at

	index do
		column :id
		column :name
		column 'Users Count' do |room|
			room.participants.count
		end
		column 'Messages Count' do |room|
			room.messages.count
		end
		column :created_at

		actions do |room|
			link_to('View', room_path(room.id), class: "member_link")
		end
	end

end
