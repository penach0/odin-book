class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, -> { Friendship.accepted }, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, -> { Friendship.accepted }, through: :inverse_friendships, source: :user

  def active_friends
    friends + inverse_friends
  end
end
