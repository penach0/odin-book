class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def owned_by?(user)
    creator_id == user.id
  end
end
