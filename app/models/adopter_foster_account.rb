# == Schema Information
#
# Table name: adopter_foster_accounts
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_adopter_foster_accounts_on_organization_id  (organization_id)
#  index_adopter_foster_accounts_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class AdopterFosterAccount < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :user
  has_one :adopter_foster_profile, dependent: :destroy
  has_many :submissions, class_name: "CustomForm::Submission", dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_pets, through: :likes, source: :pet

  scope :adopters, -> {
    joins(user: :roles).where(roles: {name: "adopter"})
  }

  scope :fosterers, -> {
    joins(user: :roles).where(roles: {name: "fosterer"})
  }
end
