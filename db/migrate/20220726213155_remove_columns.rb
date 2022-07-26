class RemoveColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :integer
    remove_column :users, :signup_role, :string
  end
end
