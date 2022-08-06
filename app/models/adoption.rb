class Adoption < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account

  # callback after_create to set status on all applications for the dog to 'adopted'
end
