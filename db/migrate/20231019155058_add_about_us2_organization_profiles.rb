class AddAboutUs2OrganizationProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_profiles, :about_us, :string, null: false
  end
end
