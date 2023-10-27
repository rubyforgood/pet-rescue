class AddDeactivatedAtToStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :deactivated_at, :datetime
  end
end
