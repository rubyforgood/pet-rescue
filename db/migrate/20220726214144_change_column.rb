class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :staff_accounts, :organization_id, :bigint, null: true
  end
end
