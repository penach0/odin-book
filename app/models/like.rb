class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :likable, polymorphic: true, counter_cache: true
end
