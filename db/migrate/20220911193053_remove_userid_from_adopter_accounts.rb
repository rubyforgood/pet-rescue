class RemoveUseridFromAdopterAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_accounts, :user_id, :bigint
    remove_column :staff_accounts, :user_id, :bigint
  end
end
