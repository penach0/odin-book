require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:latest_one)
  end

  test "valid comment" do
    assert @comment.valid?
  end

  test "invalid post" do
    @comment.body = ""

    refute @comment.valid?
  end

  test "latest_comment_by_post fetches the latest comment by post" do
    latest_comments = Comment.latest_comments_by_post.to_a

    assert_includes latest_comments, comments(:latest_one), "Failed to fetch Post1 latest comment"
    assert_includes latest_comments, comments(:latest_two), "Failed to fetch Post2 latest comment"
    assert_equal 2, latest_comments.size, "Fetched too many comments"
  end
end
