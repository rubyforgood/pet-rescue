class DropAdopterFosterProfiles < ActiveRecord::Migration[7.1]
  def change
    drop_table :adopter_foster_profiles
  end
end
