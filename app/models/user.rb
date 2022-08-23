class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  has_one :staff_account
  has_one :adopter_account

  accepts_nested_attributes_for :adopter_account, :staff_account
end
