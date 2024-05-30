class AddZipcodeToLocations < ActiveRecord::Migration[7.0]
  def up
    add_column :locations, :zipcode, :string
  end

  def down
    remove_column :locations, :zipcode, :string
  end
end
