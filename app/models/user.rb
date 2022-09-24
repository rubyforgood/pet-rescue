class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :tos_agreement, acceptance: { message: 'Please accept the Terms and Conditions' },
                            allow_nil: false, on: :create

  has_one :staff_account, dependent: :destroy
  has_one :adopter_account, dependent: :destroy

  accepts_nested_attributes_for :adopter_account, :staff_account

  # get user accounts for staff in a given organization
  def self.organization_staff(org_id)
    User.includes(:staff_account)
        .where(staff_account: { organization_id: org_id })
  end

  # used in views to show only the custom error msg without leading attribute
  def custom_messages(attribute)
    self.errors.where(attribute)
  end
end
