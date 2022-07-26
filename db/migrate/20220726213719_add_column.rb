class AddColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_accounts, :verified, :boolean, null: false, default: false
  end
end
