class CreateStaffAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :staff_accounts do |t|

      t.timestamps
    end
  end
end
