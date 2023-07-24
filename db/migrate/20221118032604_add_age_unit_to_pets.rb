class AddAgeUnitToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :age_unit, :integer, default: 0
  end
end
