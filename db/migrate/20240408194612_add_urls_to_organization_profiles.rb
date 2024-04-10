class AddUrlsToOrganizationProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :organization_profiles, :facebook_url, :text
    add_column :organization_profiles, :instagram_url, :text
    add_column :organization_profiles, :donation_url, :text
  end
end
