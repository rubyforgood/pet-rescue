# == Schema Information
#
# Table name: likes
#
#  id                        :bigint           not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  adopter_foster_account_id :bigint           not null
#  organization_id           :bigint           not null
#  pet_id                    :bigint           not null
#
# Indexes
#
#  index_likes_on_adopter_foster_account_id             (adopter_foster_account_id)
#  index_likes_on_adopter_foster_account_id_and_pet_id  (adopter_foster_account_id,pet_id) UNIQUE
#  index_likes_on_organization_id                       (organization_id)
#  index_likes_on_pet_id                                (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (adopter_foster_account_id => adopter_foster_accounts.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (pet_id => pets.id)
#
class Like < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :adopter_foster_account
  belongs_to :pet

  validates :adopter_foster_account_id, uniqueness: {scope: :pet_id}
end
