class AddColumnsToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :size, :string
    add_column :dogs, :breed, :string
    add_column :dogs, :description, :text
  end
end
