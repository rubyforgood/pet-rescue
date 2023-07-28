# == Schema Information
#
# Table name: staff_accounts
#
#  id              :bigint           not null, primary key
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           default(1), not null
#  user_id         :bigint           default(0), not null
#
# Indexes
#
#  index_staff_accounts_on_organization_id  (organization_id)
#  index_staff_accounts_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
class StaffAccount < ApplicationRecord
  acts_as_tenant(:organization)
  
  belongs_to :user

  # Active Admin getter methods
  def full_name
    user.first_name.to_s + " " + user.last_name.to_s
  end

  def email
    user.email.to_s
  end
end
