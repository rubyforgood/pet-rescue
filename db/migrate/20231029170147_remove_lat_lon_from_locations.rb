class RemoveLatLonFromLocations < ActiveRecord::Migration[7.0]
  def up
    safety_assured do
      remove_column :locations, :latitude, :float
      remove_column :locations, :longitude, :float
    end
  end

  def down
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
