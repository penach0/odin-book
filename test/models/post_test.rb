require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:first)
  end

  test "valid post" do
    assert @post.valid?
  end

  test "invalid post" do
    @post.body = ""

    refute @post.valid?
  end

  test "posts ordered from recent to older" do
    ordered_posts = Post.ordered

    assert(ordered_posts.ordered.each_cons(2).all? { |a, b| a.created_at >= b.created_at })
  end
end
