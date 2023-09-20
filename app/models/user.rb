# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tos_agreement          :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organization_id        :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_organization_id       (organization_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  acts_as_tenant(:organization)
  #
  # Handles devise
  # default_scope { where(organization_id: Current.organization&.id) }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {scope: :organization_id}
  validates :tos_agreement, acceptance: {message: "Please accept the Terms and Conditions"},
    allow_nil: false, on: :create

  has_one :staff_account, dependent: :destroy
  has_one :adopter_account, dependent: :destroy

  accepts_nested_attributes_for :adopter_account, :staff_account

  # get user accounts for staff in a given organization
  def self.organization_staff(org_id)
    User.includes(:staff_account)
      .where(staff_account: {organization_id: org_id})
  end

  # used in views to show only the custom error msg without leading attribute
  def custom_messages(attribute)
    errors.where(attribute)
  end
end
