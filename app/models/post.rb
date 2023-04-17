class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  after_commit :broadcast_new_message, on: :create
  after_commit :broadcast_edited_message, on: :update
  after_destroy_commit -> { broadcast_remove_to "posts" }

  private

  def broadcast_new_message
    broadcast_prepend_later_to "posts"
    broadcast_controls
  end

  def broadcast_edited_message
    return unless updated?

    broadcast_replace_to "posts"
    broadcast_controls
  end

  def broadcast_controls
    broadcast_append_later_to [creator, "posts"],
                              partial: "posts/creator_controls",
                              locals: { post: self, user: creator, show_page: false },
                              target: "creator_controls_#{id}"
  end

  def updated?
    created_at != updated_at
  end
end
