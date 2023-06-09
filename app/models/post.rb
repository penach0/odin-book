class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :comments, -> { order(:created_at) }, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_one :latest_comment, -> { Comment.latest_comments_by_post },
          foreign_key: :commentable_id,
          class_name: "Comment"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :with_info, ->(comments_needed) { includes(comments_needed => [commenter: [:profile]], creator: [:profile]) }

  broadcasts_to ->(post) { "posts" }, inserts_by: :prepend
end
