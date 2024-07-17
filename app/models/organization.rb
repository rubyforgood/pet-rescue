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
# Indexes
#
#  index_organizations_on_slug  (slug) UNIQUE
#
class Organization < ApplicationRecord
  # Rolify resource
  resourcify

  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :pets
  has_many :task_templates
  has_many :forms, dependent: :destroy
  has_many :faqs

  has_one :profile, dependent: :destroy, class_name: "OrganizationProfile", required: true
  has_one :location, through: :profile
  has_one :custom_page, dependent: :destroy
end
