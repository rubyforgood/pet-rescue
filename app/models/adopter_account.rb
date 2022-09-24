class AdopterAccount < ApplicationRecord
  belongs_to :user
  has_one :adopter_profile, dependent: :destroy
  has_many :adopter_applications, dependent: :destroy
  has_many :adoptions, dependent: :destroy
end
