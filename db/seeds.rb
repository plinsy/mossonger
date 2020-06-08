# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
	email = Faker::Internet.free_email
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone_number = Faker::PhoneNumber.cell_phone
  u = User.new(email: email, password: "000000", password_confirmation: "000000", first_name: first_name, last_name: last_name, phone_number: phone_number)
  u.skip_confirmation!
  u.save
end

# users
## 	avatar
## 	first_name
## 	last_name
## 	phone_number
## 	is_online
## 	friendship
## 		sender
## 		friend
## 		is_accepted
## 		is_paused
## 	chat_settings
## 		active_status
## 		enable_sounds
## 		enable_notifications
# 	problem report
# 		subject
# 		description
# 		include_screenshot
# 		screenshots
## 	dropbox
## 		trash
## 	hiding_place
##		secret
## 	space
##		alien
## 	blacklist
## 		condemned
# 	conversations
## 		logo
## 		name
## 		admin
## 		invitations
##			message
## 			guest
## 			is_accepted
## 		receive_notifications_for_messages
## 		receive_notifications_for_reactions
## 		nicknames
## 			name
## 			user
## 		messages
## 			sender
## 			content
## 			files
# 			stickers
# 			gifs
# 			voice_clip
# 			take_a_picture
# 			emoji
# 		reactions
# 			sender
# 			icon
# 			reactable
# 		template
# 		emoji
## 	readings
## 		message
## 	pages/about
# 	pages/policies
# 	privacy/explanation
# 	policies/cookies
# 	/help