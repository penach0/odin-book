require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @complete_profile = profiles(:complete)
  end

  test "valid as empty on create" do
    # skip "Not sure why the profile is not valid, it works in the console"
    empty_profile = Profile.new(user_id: 1)

    assert empty_profile.valid?
  end

  test "invalid on update without first name" do
    @complete_profile.first_name = ""

    refute @complete_profile.valid?
    assert_not_nil @complete_profile.errors[:first_name]
  end
end
