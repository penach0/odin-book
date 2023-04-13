class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  after_create_commit -> { broadcast_prepend_to "posts", locals: { user: Current.user } }
  after_update_commit -> { broadcast_replace_to "posts" }
end
