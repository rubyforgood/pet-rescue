class RemoveForeignKeyColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_applications, :adopter_account_id
    remove_column :adopter_profiles, :adopter_account_id
    remove_column :matches, :adopter_account_id
    drop_table :adopter_accounts
  end
end
