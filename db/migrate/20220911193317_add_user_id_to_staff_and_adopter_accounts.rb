class AddUserIdToStaffAndAdopterAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :adopter_accounts, :user, null: false, default: 0, foreign_key: true
    add_reference :staff_accounts, :user, null: false, default: 0, foreign_key: true
  end
end
