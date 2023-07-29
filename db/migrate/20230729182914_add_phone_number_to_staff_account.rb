class AddPhoneNumberToStaffAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :phone_number, :string
  end
end
