class User < ApplicationRecord
  after_initialize :set_default_role, if: :new_record?
  after_create :create_adopter_account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User role - default is adopter unless role already exists
  enum role: %i[adopter staff admin]

  has_one :staff_account
  has_one :adopter_account

  private

  def set_default_role
    self.role ||= :adopter
  end

  def create_adopter_account
    self.adopter_account.nil? ? AdopterAccount.create(user_id: self.id) : return
  end


end
