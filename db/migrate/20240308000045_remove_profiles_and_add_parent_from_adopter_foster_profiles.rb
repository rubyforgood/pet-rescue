class RemoveProfilesAndAddParentFromAdopterFosterProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_foster_profiles, :adopter_account_id, :bigint
    remove_column :adopter_foster_profiles, :foster_account_id, :bigint

    add_reference :adopter_foster_profiles, :parent, polymorphic: true, index: true
  end
end
