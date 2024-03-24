class RemoveRolifyWithStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    drop_table :roles
    drop_table :staff_accounts_roles
  end
end
