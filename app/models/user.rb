class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, foreign_key: :friend_id, class_name: "Friendship", dependent: :destroy
  has_many :friends, -> { Friendship.accepted }, through: :friendships
  has_many :inverse_friends, -> { Friendship.accepted }, through: :inverse_friendships, source: :user
  has_many :requestees, -> { Friendship.pending }, through: :friendships, source: :friend
  has_many :requesters, -> { Friendship.pending }, through: :inverse_friendships, source: :user

  has_one :profile, dependent: :destroy
  has_many :created_posts, foreign_key: :creator_id, class_name: "Post", dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user.id) }

  def active_friends
    friends + inverse_friends
  end

  def request_sent?(other)
    requestees.where(id: other.id).exists?
  end

  def request_received?(other)
    requesters.where(id: other.id).exists?
  end

  def friend?(other)
    active_friends.include?(other)
  end
end
