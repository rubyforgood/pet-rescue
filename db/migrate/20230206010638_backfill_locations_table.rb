class BackfillLocationsTable < ActiveRecord::Migration[7.0]
  
  class MigrateAdopterProfile < ActiveRecord::Base
    self.table_name = :adopter_profiles
  end

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
