class AdopterProfile < ApplicationRecord
  belongs_to :adopter_account

  validates :phone_number, presence: true
  validates :contact_method, presence: true
  validates :country, presence: true
  validates :province_state, presence: true
  validates :city_town, presence: true
  validates :ideal_dog, presence: true, length: { maximum: 200 }
  validates :lifestyle_fit, presence: true, length: { maximum: 200 }
  validates :activities, presence: true, length: { maximum: 200 }
  validates :alone_weekday, presence: true
  validates :alone_weekend, presence: true
  validates :experience, presence: true, length: { maximum: 200 }
  validates :contingency_plan, presence: true, length: { maximum: 200 }
  validates :shared_ownership, presence: true
  validates :shared_owner, presence: true, length: { maximum: 200 }
  validates :housing_type, presence: true
  validates :fenced_access, presence: true
  validates :fenced_alternative, presence: true, length: { maximum: 200 }
  validates :location_day, presence: true, length: { maximum: 50 }
  validates :location_night, presence: true, length: { maximum: 50 }
  validates :do_you_rent, presence: true
  validates :dogs_allowed, presence: true
  validates :adults_in_home, presence: true
  validates :kids_in_home, presence: true
  validates :other_pets, presence: true
  validates :describe_pets, presence: true, length: { maximum: 200 }
  validates :checked_shelter, presence: true
  validates :surrendered_pet, presence: true
  validates :describe_surrender, presence: true, length: { maximum: 200 }
  validates :annual_cost, presence: true
end
