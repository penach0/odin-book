class MakeCommentsPolymorphic < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :commentable, polymorphic: true
    reversible do |dir|
      dir.up { Comment.update_all("commentable_id = commented_post_id, commentable_type = 'Post'") }
      dir.down { Comment.update_all("commented_post_id = commentable_id") }
    end
    remove_reference :comments,
                     :commented_post,
                     foreign_key: { to_table: :posts, column: :commented_post_id },
                     index: true
  end
end
