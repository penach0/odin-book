class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :likable, polymorphic: true, null: false
      t.index [:liker_id, :likable_id, :likable_type], unique: true

      t.timestamps
    end
  end
end
