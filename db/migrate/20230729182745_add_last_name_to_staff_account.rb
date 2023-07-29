class AddLastNameToStaffAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :last_name, :string
  end
end
