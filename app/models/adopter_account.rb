class AdopterAccount < ApplicationRecord
  belongs_to :user
  has_one :adopter_profile
  has_many :applications
end
