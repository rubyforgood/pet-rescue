class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
    add_reference :users, :organization
  end
end
