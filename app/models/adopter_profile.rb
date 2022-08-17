class AdopterProfile < ApplicationRecord
  belongs_to :adopter_account

  validates :phone_number, presence: { message: 'cannot be blank' }
  validates :contact_method, presence: { message: 'must be selected' }
  validates :country, presence: { message: 'must be selected' }
  validates :province_state, presence: { message: 'must be selected' }
  validates :city_town, presence: { message: 'cannot be blank' }
  validates :ideal_dog, presence: { message: 'cannot be blank' }, length: { maximum: 200 }
  validates :lifestyle_fit, presence: true, length: { maximum: 200 }
  validates :activities, presence: true, length: { maximum: 200 }
  validates :alone_weekday, presence: true
  validates :alone_weekend, presence: true
  validates :experience, presence: true, length: { maximum: 200 }
  validates :contingency_plan, presence: true, length: { maximum: 200 }
  validates_inclusion_of :shared_ownership, in: [true, false]
  validates :shared_owner, length: { maximum: 200 }
  validates :housing_type, presence: true
  validates_inclusion_of :fenced_access, in: [true, false]
  validates :fenced_alternative, length: { maximum: 200 }
  validates :location_day, presence: true, length: { maximum: 50 }
  validates :location_night, presence: true, length: { maximum: 50 }
  validates_inclusion_of :do_you_rent, in: [true, false]
  validates :adults_in_home, presence: true
  validates :kids_in_home, presence: true
  validates_inclusion_of :other_pets, in: [true, false]
  validates :describe_pets, length: { maximum: 200 }
  validates_inclusion_of :checked_shelter, in: [true, false]
  validates_inclusion_of :surrendered_pet, in: [true, false]
  validates :describe_surrender, length: { maximum: 200 }
  validates :annual_cost, presence: true
end
