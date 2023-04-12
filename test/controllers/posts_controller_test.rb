require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    @post = posts(:first)
    sign_in @user
  end

  test "should get index" do
    get user_posts_url(@user)
    assert_response :success
  end

  test "should get show" do
    get post_url(@post)
    assert_response :success
  end

  test "should get new" do
    get new_user_post_url(@user)
    assert_response :success
  end

  test "should create the post with correct data" do
    assert_difference("Post.count") do
      post user_posts_url(@user), params: { post: { body: "Correct data" } }
    end

    assert_redirected_to post_path(Post.last)
  end

  test "should not save post when trying to create with incorrect data" do
    assert_no_difference("Post.count") do
      post user_posts_url(@user), params: { post: { body: "" } }
    end

    assert_response :unprocessable_entity
    # assert_template :new
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post with correct data" do
    body_update = "Correct data"

    patch post_url(@post), params: { post: { body: body_update } }
    assert_redirected_to post_url(@post)

    @post.reload
    assert_equal body_update, @post.body
  end

  test "should not update post with incorrect data" do
    body_update = ""

    patch post_url(@post), params: { post: { body: body_update } }
    assert_response :unprocessable_entity

    @post.reload
    refute_equal body_update, @post.body
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to user_posts_path(@user)
  end
end
