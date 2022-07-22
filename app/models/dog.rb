class Dog < ApplicationRecord
  belongs_to :organization
  has_many :applications
  has_one :adoption
end
