class RemoveFirstNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :first_name, :string
  end
end
