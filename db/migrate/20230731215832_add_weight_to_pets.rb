class AddWeightToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :weight_from, :integer, null: false
    add_column :pets, :weight_to, :integer, null: false
    add_column :pets, :weight_unit, :string, null: false
  end
end
