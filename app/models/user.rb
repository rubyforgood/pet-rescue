# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tos_agreement          :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#  organization_id        :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_organization_id       (organization_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Avatarable

  acts_as_tenant(:organization)
  default_scope do
    #
    # Used as a extra measure to scope down the options for devise
    # when the Current.organization is set
    #
    if Current.organization
      where(organization_id: Current.organization&.id)
    else
      all
    end
  end

  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {scope: :organization_id}, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  }
  # validates :tos_agreement, acceptance: {message: "Please accept the Terms and Conditions"},
  #   allow_nil: false, on: :create

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

  def active_for_authentication?
    super && !staff_account&.deactivated_at
  end

  def inactive_message
    staff_account.deactivated_at ? :deactivated : super
  end
end
