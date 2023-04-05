EMAILS = [
  "sillysally@email.com",
  "captaincrunchy@yahoo.com",
  "quirkyquincy@gmail.com",
  "boopadoop@aol.com",
  "snickerdoodle@hotmail.com",
  "bazinga@outlook.com",
  "hugabug@icloud.com",
  "chucklesmcgee@protonmail.com",
  "fuzzywuzzy@rocketmail.com",
  "gigglebox@yandex.com"
].freeze

User.delete_all
Friendship.delete_all

EMAILS.each { |email| User.create(email: email, password: "123456") }
