class AddSignupRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :signup_role, :string 
  end
end
