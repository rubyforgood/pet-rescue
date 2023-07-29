# == Schema Information
#
# Table name: positions
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  organization_id  :bigint
#  staff_account_id :bigint
#
# Indexes
#
#  index_positions_on_organization_id   (organization_id)
#  index_positions_on_staff_account_id  (staff_account_id)
#
class Position < ApplicationRecord
end
