class DropOrganizationProfiles < ActiveRecord::Migration[7.1]
  def change
    drop_table :organization_profiles
  end
end
