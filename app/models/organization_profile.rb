# == Schema Information
#
# Table name: organization_profiles
#
#  id              :bigint           not null, primary key
#  donation_url    :text
#  email           :string
#  facebook_url    :text
#  instagram_url   :text
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
  include Avatarable

  belongs_to :location
  acts_as_tenant(:organization, inverse_of: :profile)
  accepts_nested_attributes_for :location
  validates_associated :location

  before_save :normalize_phone

  validates :phone_number, phone: {possible: true, allow_blank: true}
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :facebook_url, url: true, allow_blank: true
  validates :instagram_url, url: true, allow_blank: true
  validates :donation_url, url: true, allow_blank: true

  delegate :name, to: :organization

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
