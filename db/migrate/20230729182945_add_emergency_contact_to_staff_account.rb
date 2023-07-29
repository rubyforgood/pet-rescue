class AddEmergencyContactToStaffAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :emergency_contact, :string
  end
end
