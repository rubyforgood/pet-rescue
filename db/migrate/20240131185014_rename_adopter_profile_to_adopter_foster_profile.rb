class RenameAdopterProfileToAdopterFosterProfile < ActiveRecord::Migration[7.0]
  def change
    rename_table :adopter_profiles, :adopter_foster_profiles
  end
end
