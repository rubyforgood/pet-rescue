class StaffAccount < ApplicationRecord
  belongs_to :organization
  belongs_to :user
end
