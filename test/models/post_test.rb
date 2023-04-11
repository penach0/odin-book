require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  test "valid post" do
    assert @post.valid?
  end

  test "invalid post" do
    @post.body = ""

    refute @post.valid?
  end
end
