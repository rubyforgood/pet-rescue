class AddOrganizationIdToStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :staff_accounts, :organization, null: false, foreign_key: true
  end
end
