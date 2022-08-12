class RemoveColumnsFromAdopterProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_profiles, :city, :string
    remove_column :adopter_profiles, :country, :string
    remove_column :adopter_profiles, :experience, :string
  end
end
