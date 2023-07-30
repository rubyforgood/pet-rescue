class RenameAdoptionProfilesToPeople < ActiveRecord::Migration[7.0]
  def change
    rename_table :adopter_profiles, :people
  end
end
