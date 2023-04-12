class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  after_create_commit do
    -> { broadcast_prepend_to "posts", partial: "posts/post", locals: { post: self }, target: "posts" }
  end
end
