class AddOrgIdToTables < ActiveRecord::Migration[7.1]
  def change
    add_reference :adopter_applications, :organization, null: false
    add_reference :adopter_foster_accounts, :organization, null: false
    add_reference :adopter_foster_profiles, :organization, null: false
    add_reference :tasks, :organization, null: false
  end
end
