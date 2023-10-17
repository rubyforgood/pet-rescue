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
  rolify

  def email
    user.email.to_s
  end

  def status
    user.invited_to_sign_up? ? :invitation_sent : :enabled
  end
end
