class AddAdopterFosterAccountIdToAdopterFosterProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_foster_profiles, :adopter_foster_account_id, :integer
    add_index :adopter_foster_profiles, :adopter_foster_account_id
  end
end
