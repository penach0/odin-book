class PopulatePostCommentCount < ActiveRecord::Migration[7.0]
  def up
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments)
    end
  end
end
