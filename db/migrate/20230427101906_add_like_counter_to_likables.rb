class AddLikeCounterToLikables < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes_count, :integer
    add_column :comments, :likes_count, :integer
  end
end
