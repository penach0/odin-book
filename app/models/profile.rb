class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :date_of_birth, :bio, presence: true, on: :update

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def incomplete?
    attributes.values.any?(&:nil?)
  end
end
