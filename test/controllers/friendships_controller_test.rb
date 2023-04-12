require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    @not_friend = users(:three)
    sign_in @user
  end

  test "should create friendship between non_friends" do
    assert_difference('Friendship.count') do
      post friendships_url, params: { friend_id: @not_friend.id }
    end

    @request.headers["Referer"] = users_url

    assert_redirected_to "www.whereicamefrom.com"
  end
end
