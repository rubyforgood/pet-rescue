class StaffAccount < ApplicationRecord
  belongs_to :organization
  belongs_to :user

   # Active Admin getter methods
  def full_name
    user.first_name.to_s + " " + user.last_name.to_s
  end

  def email
    user.email.to_s
  end
end
