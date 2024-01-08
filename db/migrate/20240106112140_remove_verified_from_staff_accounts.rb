class RemoveVerifiedFromStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :staff_accounts, :verified
  end
end
