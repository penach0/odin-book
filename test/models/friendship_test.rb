require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friendship = friendships(:one)
  end

  test "pending scope returns pending friendships" do
    assert_includes Friendship.pending, @friendship

    @friendship.accepted!
    refute_includes Friendship.pending, @friendship
  end

  test "accepted scope returns accepted friendships" do
    @friendship.accepted!
    assert_includes Friendship.accepted, @friendship

    @friendship.pending!
    refute_includes Friendship.accepted, @frienship
  end

  test "finds friendship with normal order" do
    user_id = @friendship.user_id
    friend_id = @friendship.friend_id

    result = Friendship.find_interchangeable(user_id, friend_id)

    assert_equal @friendship, result
  end

  test "finds friendship with reverse order" do
    @friendship.user = users(:two)
    @friendship.friend = users(:one)

    user_id = @friendship.user_id
    friend_id = @friendship.friend_id

    result = Friendship.find_interchangeable(user_id, friend_id)

    assert_equal @friendship, result
  end
end
