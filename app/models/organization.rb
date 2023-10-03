# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  resourcify # rolify
  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :pets
  belongs_to :location
end
