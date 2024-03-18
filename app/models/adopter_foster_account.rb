<<<<<<< HEAD
# == Schema Information
#
# Table name: adopter_foster_accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_adopter_foster_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
=======
>>>>>>> 610a426 (Update with AdopterFosterAccount files)
class AdopterFosterAccount < ApplicationRecord
  belongs_to :user
  has_one :adopter_foster_profile, as: :caretaker
end
