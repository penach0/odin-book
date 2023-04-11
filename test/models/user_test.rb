require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invadid without email' do
    @user.email = ""

    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end
end
