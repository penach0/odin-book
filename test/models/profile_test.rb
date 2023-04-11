require "test_helper"
require "pry"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @complete_profile = profiles(:complete)
    @incomplete_profile = profiles(:incomplete)
  end

  test "should be valid when empty on create" do
    user = users(:one)
    empty_profile = user.build_profile

    assert empty_profile.valid?
  end

  test "should be invalid with first name empty on update" do
    @complete_profile.first_name = ""

    refute @complete_profile.valid?
    assert_not_nil @complete_profile.errors[:first_name]
  end

  test "should be invalid with last name empty on update" do
    @complete_profile.last_name = ""

    refute @complete_profile.valid?
    assert_not_nil @complete_profile.errors[:last_name]
  end

  test "shoud be valid on update with just first and last name given" do
    assert @incomplete_profile.valid?
  end

  test "#full name" do
    full_name = "#{@complete_profile.first_name} #{@complete_profile.last_name}"

    assert_equal @complete_profile.full_name, full_name
  end

  test "#age" do
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
