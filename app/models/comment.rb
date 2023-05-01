class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :latest_comments_by_post, lambda {
    latest_comments_ids = select("max(id)").group(:commented_post_id)
    where(id: latest_comments_ids)
  }

  broadcasts_to ->(comment) { [comment.commented_post, :comments] },
                target: ->(comment) { "post_#{comment.commented_post.id}_comments" }
end
