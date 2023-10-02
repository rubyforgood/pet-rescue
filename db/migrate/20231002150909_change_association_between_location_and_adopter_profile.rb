class ChangeAssociationBetweenLocationAndAdopterProfile < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def up
    safety_assured do
      add_reference :adopter_profiles, :location, foreign_key: true, index: {algorithm: :concurrently}

      execute <<-SQL
        UPDATE adopter_profiles
        SET location_id = locations.id
        FROM locations
        WHERE locations.adopter_profile_id = adopter_profiles.id
      SQL

      remove_reference :locations, :adopter_profile
      change_column_null :adopter_profiles, :location_id, false
    end
  end

  def down
    safety_assured do
      add_reference :locations, :adopter_profile, foreign_key: true, index: {algorithm: :concurrently}

      execute <<-SQL
        UPDATE locations
        SET adopter_profile_id = adopter_profiles.id
        FROM adopter_profiles
        WHERE locations.id = adopter_profiles.location_id
      SQL

      remove_reference :adopter_profiles, :location
      change_column_null :locations, :adopter_profile_id, false
    end
  end
end
