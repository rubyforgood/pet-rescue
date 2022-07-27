class ChangeStaffAccountsColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :staff_accounts, :organization_id, :bigint, default: 1
    change_column :staff_accounts, :organization_id, :bigint, null: false
  end
end
