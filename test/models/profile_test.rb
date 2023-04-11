require "test_helper"
require "pry"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @complete_profile = profiles(:complete)
  end

  test "valid as empty on create" do
    empty_profile = Profile.new(user_id: users(:one).id)

    assert empty_profile.valid?
  end

  test "invalid on update without first name" do
    @complete_profile.first_name = ""

    refute @complete_profile.valid?
    assert_not_nil @complete_profile.errors[:first_name]
  end

  test "invalid on update without last name" do
    @complete_profile.last_name = ""

    refute @complete_profile.valid?
    assert_not_nil @complete_profile.errors[:last_name]
  end

  test "valid on update with just first and last name" do
    incomplete_profile = profiles(:incomplete)

    assert incomplete_profile.valid?
  end
end
