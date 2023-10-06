class AddSpecies2Pets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :species, :integer, null: false
  end
end
