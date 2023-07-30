class DropAdminUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :admin_users
  end
end
