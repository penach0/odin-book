class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, [:pending, :accepted, :rejected]

  scope :accepted, -> { where(status: :accepted) }
end
