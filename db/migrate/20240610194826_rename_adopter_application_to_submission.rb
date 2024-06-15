class RenameAdopterApplicationToSubmission < ActiveRecord::Migration[7.1]
  def change
    remove_index :adopter_applications, :adopter_foster_account_id
    remove_index :adopter_applications, :organization_id
    remove_index :adopter_applications, [:pet_id, :adopter_foster_account_id], unique: true
    remove_index :adopter_applications, :pet_id

    rename_table :adopter_applications, :submissions

    add_index :submissions, :adopter_foster_account_id
    add_index :submissions, :organization_id
    add_index :submissions, [:pet_id, :adopter_foster_account_id], unique: true
    add_index :submissions, :pet_id
  end
end
