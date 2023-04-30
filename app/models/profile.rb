class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, presence: true

  def self.from_omniauth(user, auth)
    return if user.profile

    name = auth.info.name.split

    user.create_profile(
      first_name: name.first,
      last_name: name.last
    )
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    return unless date_of_birth

    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def incomplete?
    attributes.values.any?(&:nil?)
  end

  def required_info?
    [first_name, last_name].none?(&:blank?)
  end
end
