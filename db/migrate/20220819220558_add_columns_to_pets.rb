class AddColumnsToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :size, :string
    add_column :pets, :breed, :string
    add_column :pets, :description, :text
  end
end
