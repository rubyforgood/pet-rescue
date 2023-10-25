# == Schema Information
#
# Table name: adopter_accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_adopter_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class AdopterAccount < ApplicationRecord
  belongs_to :user
  has_one :adopter_profile, dependent: :destroy
  has_many :adopter_applications, dependent: :destroy
  has_many :matches, dependent: :destroy
end
