class AddInterchangeableUniqueIndexToFriendships < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        remove_index :friendships, name: "index_friendships_on_user_id_and_friend_id"

        connection.execute(%(
          create unique index index_friendships_on_interchangeable_and_user_id_friend_id
          on friendships(greatest(user_id, friend_id, least(user_id, friend_id)));

          create unique index index_friendships_on_interchangeable_friend_id_and_user_id
          on friendships(greatest(friend_id, user_id, least(friend_id, user_id)));
        ))
      end

      dir.down do
        connection.execute(%(
          drop index_friendships_on_interchangeable_and_user_id_friend_id;

          drop index_friendships_on_interchangeable_friend_id_and_user_id;
        ))

        add_index :friendships, ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
      end
    end
  end
end
