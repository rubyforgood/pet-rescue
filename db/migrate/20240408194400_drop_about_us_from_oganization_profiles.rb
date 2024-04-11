class DropAboutUsFromOganizationProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :organization_profiles, :about_us
  end
end
