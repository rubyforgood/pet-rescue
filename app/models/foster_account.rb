# == Schema Information
#
# Table name: foster_accounts
#
#  id      :bigint           not null, primary key
#  user_id :bigint
#
# Indexes
#
#  index_foster_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class FosterAccount < ApplicationRecord
  belongs_to :user
end  
