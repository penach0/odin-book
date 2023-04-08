class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, [:pending, :accepted]

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: :pending) }

  def owned_by?(user)
    friend_id == user.id
  end
end
