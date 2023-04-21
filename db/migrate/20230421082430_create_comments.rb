class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commenter, null: false, foreign_key: { to_table: :users }
      t.references :commented_post, null: false, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
