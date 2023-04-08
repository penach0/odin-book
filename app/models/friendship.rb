class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, [:pending, :accepted]

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: :pending) }

  def self.find_interchangeable(first_user, second_user)
    where(user_id: first_user, friend_id: second_user)
      .or(where(user_id: second_user, friend_id: first_user)).take
  end
end
