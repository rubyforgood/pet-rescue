class Dog < ApplicationRecord
  belongs_to :organization
  has_many :adopter_applications
  has_one :adoption
  has_many :images
end
