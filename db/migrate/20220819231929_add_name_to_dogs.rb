class AddNameToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :name, :string
    add_index :dogs, :name, unique: true
  end
end
