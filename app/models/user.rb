class User < ApplicationRecord
  
  # after_create :create_adopter_account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :staff_account
  has_one :adopter_account

  accepts_nested_attributes_for :adopter_account, :staff_account

  private


  # def create_adopter_account
  #   self.adopter? && self.adopter_account.nil? ? AdopterAccount.create(user_id: self.id) : return
  # end
end
