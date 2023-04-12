require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    @profile = @user.profile
    sign_in @user
  end

  test "should get show" do
    get user_profile_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_profile_url(@user)
    assert_response :success
  end

  test "should update profile with correct data" do
    bio_update = "Test Bio"

    patch user_profile_url(@user), params: { profile: { id: @profile.id, bio: bio_update } }
    assert_redirected_to user_profile_url(@user)

    @profile.reload
    assert_equal bio_update, @profile.bio
  end

  test "should render edit again with incorrect data" do
    patch user_profile_url(@user), params: { profile: { id: @profile.id, first_name: "" } }

    assert_response :unprocessable_entity
  end
end
