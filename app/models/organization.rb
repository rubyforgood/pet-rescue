class Organization < ApplicationRecord

  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :dogs

end
