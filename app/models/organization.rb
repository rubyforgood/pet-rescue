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
#
# Indexes
#
#  index_organizations_on_slug  (slug) UNIQUE
#
class Organization < ApplicationRecord
  include Avatarable
  include Phoneable

  # Rolify resource
  resourcify

  has_many :staff_accounts
  has_many :users, through: :staff_accounts
  has_many :pets
  has_many :default_pet_tasks
  has_many :forms, class_name: "CustomForm::Form", dependent: :destroy
  has_many :faqs
  has_many :people
  has_one :form_submission, dependent: :destroy
  has_one :custom_page, dependent: :destroy


  has_many :locations
  accepts_nested_attributes_for :locations

  before_save :normalize_phone

  validates :phone_number, phone: {possible: true, allow_blank: true}
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :facebook_url, url: true, allow_blank: true
  validates :instagram_url, url: true, allow_blank: true
  validates :donation_url, url: true, allow_blank: true

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
