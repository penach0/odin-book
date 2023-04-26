require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @comment = comments(:one)
    @post = posts(:first)
  end

  test "should get new" do
    get new_post_comment_url(@post)
    assert_response :success
  end
end
