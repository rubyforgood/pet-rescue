class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :tos_agreement, acceptance: {message: "Please accept the Terms and Conditions"},
    allow_nil: false, on: :create


  has_one :person, dependent: :destroy
  belongs_to :organization
  enum role: [:staff, :admin]

  accepts_nested_attributes_for :person

  # get user accounts for staff in a given organization
  def self.organization_staff
    User.where(role: :staff).where(organization: organization)
  end

  # used in views to show only the custom error msg without leading attribute
  def custom_messages(attribute)
    errors.where(attribute)
  end
end
