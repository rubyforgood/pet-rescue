class DropStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    drop_table :adopter_accounts
  end
end
