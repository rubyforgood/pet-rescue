class AddNameToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :name, :string
    add_index :pets, :name, unique: true
  end
end
