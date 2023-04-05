USERS = [
  { email: "sillysally@email.com", first_name: "Emma", last_name: "Smith" },
  { email: "captaincrunchy@yahoo.com", first_name: "Noah", last_name: "Johnson" },
  { email: "quirkyquincy@gmail.com", first_name: "Ava", last_name: "Williams" },
  { email: "boopadoop@aol.com", first_name: "Liam", last_name: "Brown" },
  { email: "snickerdoodle@hotmail.com", first_name: "Sophia", last_name: "Garcia" },
  { email: "bazinga@outlook.com", first_name: "William", last_name: "Jones" },
  { email: "hugabug@icloud.com", first_name: "Isabella", last_name: "Miller" },
  { email: "chucklesmcgee@protonmail.com", first_name: "James", last_name: "Davis" },
  { email: "fuzzywuzzy@rocketmail.com", first_name: "Mia", last_name: "Martinez" },
  { email: "gigglebox@yandex.com", first_name: "Benjamin", last_name: "Rodriguez" }
].freeze

User.delete_all
Friendship.delete_all
Profile.delete_all

USERS.each do |user|
  current_user = User.create(email: user[:email], password: "123456")
  current_user.create_profile(first_name: user[:first_name], last_name: user[:last_name])
end
