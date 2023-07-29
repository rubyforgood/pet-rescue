class AddFirstNameToStaffAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :first_name, :string
  end
end
