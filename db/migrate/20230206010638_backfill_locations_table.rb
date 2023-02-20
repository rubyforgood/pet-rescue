class BackfillLocationsTable < ActiveRecord::Migration[7.0]
  # create class for table instead of referring directly to model
  # this means any change in name is captured in migrations and a non issue
  class MigrateAdopterProfile < ActiveRecord::Base
    self.table_name = :adopter_profiles
  end

  # create class for table instead of referring directly to model
  # this means any change in name is captured in migrations and a non issue
  class MigrateLocation < ActiveRecord::Base
    self.table_name = :locations
  end

  def up
    MigrateAdopterProfile.find_each do |profile|
      MigrateLocation.create!(
        country: profile.country,
        province_state: profile.province_state,
        city_town: profile.city_town,
        adopter_profile_id: profile.id
      )
    end
  end

  def down
    MigrateLocation.find_each(&:destroy!)
  end
end
