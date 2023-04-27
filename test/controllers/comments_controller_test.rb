require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @comment = comments(:latest_one)
    @post = @comment.commented_post
  end

  test "should get new" do
    get new_post_comment_url(@post)
    assert_response :success
  end

  test "should create comment with correct data" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "Correct data" , user_id: @user.id } },
                                     headers: { referer: user_posts_url(@user) }
    end

    assert_redirected_to user_posts_url(@user)
  end

  test "should create comment with correct data via Turbo Streams" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "Correct data" } }, as: :turbo_stream
    end

    assert_turbo_stream action: :append, target: "post_#{@post.id}_comments"
    assert_turbo_stream action: :update, target: "post_#{@post.id}_new_comment"
  end

  test "should not save comment when trying to create with incorrect data" do
    assert_no_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment with correct data" do
    body_update = "Correct data"

    patch comment_url(@comment), params: { comment: { body: body_update } },
                                 headers: { referer: user_posts_url(@user) }

    assert_redirected_to user_posts_url(@user)

    @comment.reload
    assert_equal body_update, @comment.body
  end

  test "should not update comment with incorrect data" do
    body_update = ""

    patch comment_url(@comment), params: { comment: { body: body_update } }
    assert_response :unprocessable_entity

    @comment.reload
    refute_equal body_update, @comment.body
  end

  test "should destroy comment via HTML" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to post_url(@post)
  end

  test "should destroy comment via Turbo Stream" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment), as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: @comment
  end
end
