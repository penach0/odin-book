require "test_helper"
require "pry"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @complete_profile = profiles(:complete)
    @incomplete_profile = profiles(:incomplete)
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
    assert @incomplete_profile.valid?
  end

  test "can return full name" do
    full_name = "#{@complete_profile.first_name} #{@complete_profile.last_name}"

    assert_equal @complete_profile.full_name, full_name
  end

  test "can return age" do
    age = 27

    assert_equal @complete_profile.age, age
  end

  test "correctly checks for completion" do
    refute @complete_profile.incomplete?
    assert @incomplete_profile.incomplete?
  end

  test "correctly checks presence of required info" do
    assert @complete_profile.required_info?

    @complete_profile.first_name = ""

    refute @complete_profile.required_info?
  end
end
