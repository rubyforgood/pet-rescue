class AdopterFosterAccount < ApplicationRecord
  belongs_to :user
  has_one :adopter_foster_profile, as: :caretaker
end
