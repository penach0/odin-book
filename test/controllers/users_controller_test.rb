require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get show" do
    get user_url(@user)
    assert_response :success
  end
end
