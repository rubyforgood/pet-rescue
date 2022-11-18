class AddAgeUnitToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :age_unit, :integer, default: 0
  end
end
