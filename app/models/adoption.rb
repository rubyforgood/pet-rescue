class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :adopter_account
end
