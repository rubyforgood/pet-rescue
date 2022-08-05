class AdopterApplication < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account
  has_one :adoption

  enum :status, [:awaiting_review, :under_review, :adoption_pending]

end
