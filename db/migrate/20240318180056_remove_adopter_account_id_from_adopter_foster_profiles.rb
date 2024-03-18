class RemoveAdopterAccountIdFromAdopterFosterProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_foster_profiles, :adopter_account_id, :bigint
  end
end
