class RemoveLatLonFromLocations < ActiveRecord::Migration[7.0]
  def up
    remove_column :locations, :latitude, :float
    remove_column :locations, :longitude, :float
  end

  def down
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
