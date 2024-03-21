class RenameAdopterAccountColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :adopter_applications, :adopter_account_id, :adopter_foster_account_id
    rename_column :adopter_foster_profiles, :adopter_account_id, :adopter_foster_account_id
    rename_column :matches, :adopter_account_id, :adopter_foster_account_id

    remove_index :adopter_foster_profiles, name: "index_adopter_foster_profiles_on_adopter_foster_account_id"
    # Ensure only one AdopterFosterProfile per AdopterFosterAccount with unique: true
    add_index :adopter_foster_profiles, :adopter_foster_account_id, unique: true
  end
end
