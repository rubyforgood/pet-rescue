class DropStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    drop_table :staff_accounts
  end
end
