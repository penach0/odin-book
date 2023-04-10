require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = users(:one)
    assert user.valid?
  end

  test 'invadid without email' do
    user = users(:one)
    user.email = ""

    refute user.valid?
    assert_not_nil user.errors[:email]
  end
end
