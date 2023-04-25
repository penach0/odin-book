class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :commented_post, class_name: "Post", counter_cache: true

  validates :body, presence: true

  scope :latest_comments_by_post, lambda {
    latest_comments_ids = select("max(id)").group(:commented_post_id)
    where(id: latest_comments_ids)
  }

  broadcasts_to ->(comment) { [comment.commented_post, :comments] },
                target: ->(comment) { "post_#{comment.commented_post.id}_comments" }
end
