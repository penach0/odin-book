class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :comments, foreign_key: :commented_post_id, class_name: "Comment", dependent: :destroy

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  broadcasts_to ->(post) { "posts" }, inserts_by: :prepend
end
