class Application < ApplicationRecord
  belongs_to :dog
  belongs_to :adopter_account
end
