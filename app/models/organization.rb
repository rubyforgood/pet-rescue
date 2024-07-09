# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  donation_url  :text
#  email         :string
#  facebook_url  :text
#  instagram_url :text
#  name          :string
#  phone_number  :string
#  slug          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  location_id   :bigint           not null
#
# Indexes
#
#  index_organizations_on_location_id  (location_id)
#  index_organizations_on_slug         (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Organization < ApplicationRecord
  # Rolify resource
  resourcify

  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :pets
  has_many :default_pet_tasks
  has_many :forms, class_name: "CustomForm::Form", dependent: :destroy
  has_many :faqs

  # has_one :profile, dependent: :destroy, class_name: "OrganizationProfile", required: true
  # has_one :location, through: :profile
  has_one :custom_page, dependent: :destroy

  belongs_to :location
  accepts_nested_attributes_for :location
  validates_associated :location

end
