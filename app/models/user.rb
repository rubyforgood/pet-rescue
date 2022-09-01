class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_acceptance_of :tos_agreement, allow_nil: false, on: :create

  has_one :staff_account
  has_one :adopter_account

  accepts_nested_attributes_for :adopter_account, :staff_account

  # get user accounts for staff in a given organization
  def self.organization_staff(org_id)
    User.includes(:staff_account)
        .where(staff_account: { organization_id: org_id })
  end
end
