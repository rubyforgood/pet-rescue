class RemoveLastNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :last_name, :string
  end
end
