class RenameAdopterAccountColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :adopter_applications, :adopter_account_id, :adopter_foster_account_id
    rename_column :adopter_foster_profiles, :adopter_account_id, :adopter_foster_account_id
    rename_column :matches, :adopter_account_id, :adopter_foster_account_id

    add_index :adopter_applications, :adopter_foster_account_id
    add_index :adopter_foster_profiles, :adopter_foster_account_id
    add_index :matches, :adopter_foster_account_id

    add_foreign_key :adopter_applications, :adopter_foster_accounts, column: :adopter_foster_account_id
    add_foreign_key :adopter_foster_profiles, :adopter_foster_accounts, column: :adopter_foster_account_id
    add_foreign_key :matches, :adopter_foster_accounts, column: :adopter_foster_account_id
  end
end
