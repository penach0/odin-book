class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  broadcasts_to ->(post) { "posts" }, inserts_by: :prepend
end
