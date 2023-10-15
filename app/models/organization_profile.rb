# == Schema Information
#
# Table name: organization_profiles
#
#  id              :bigint           not null, primary key
#  email           :string
#  phone_number    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_organization_profiles_on_location_id      (location_id)
#  index_organization_profiles_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class OrganizationProfile < ApplicationRecord
  belongs_to :location
  belongs_to :organization

  accepts_nested_attributes_for :location
  validates_associated :location

  before_save :normalize_phone

  validates :phone_number, phone: {possible: true, allow_blank: true}

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
