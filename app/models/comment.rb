class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true

  scope :latest_comments_by_post, lambda {
    latest_comments_ids = select("max(id)").group(:commentable_id).having(commentable_type: "Post")
    where(id: latest_comments_ids)
  }

  broadcasts_to ->(comment) { [comment.commentable, :comments] },
                target: ->(comment) { "post_#{comment.commentable.id}_comments" }
end
