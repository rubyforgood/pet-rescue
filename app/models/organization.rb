# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :bigint
#
# Indexes
#
#  index_organizations_on_location_id  (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Organization < ApplicationRecord
  resourcify # rolify
  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :pets
  belongs_to :location, dependent: :destroy
end
