class Application < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account

  enum :status, [:awaiting_review, :under_review, :adoption_pending]
end
