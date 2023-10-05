# == Schema Information
#
# Table name: organization_profiles
#
#  id              :bigint           not null, primary key
#  email           :string
#  phone_number    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :bigint
#  organization_id :bigint
#
# Indexes
#
#  index_organization_profiles_on_location_id      (location_id)
#  index_organization_profiles_on_organization_id  (organization_id)
#
class OrganizationProfile < ApplicationRecord
  belongs_to :location
  belongs_to :organization
end
