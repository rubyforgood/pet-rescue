class AddUserIdToStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :staff_accounts, :user, null: false, foreign_key: true
  end
end
