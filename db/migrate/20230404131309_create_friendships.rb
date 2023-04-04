class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :friend, null: false, foreign_key: { to_table: :users }
      t.index [:user_id, :friend_id], unique: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
