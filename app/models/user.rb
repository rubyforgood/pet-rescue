class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User role - default is adopter unless role already exists
  enum role: %i[adopter staff admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :adopter
  end

  # this causes an error unknown key :through
  # belongs_to :organization, through: :staff_accounts
  
  has_one :staff_account
end
