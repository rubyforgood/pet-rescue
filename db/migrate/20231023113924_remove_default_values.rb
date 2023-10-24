class RemoveDefaultValues < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:adopter_accounts, :user_id, nil)
    change_column_default(:staff_accounts, :organization_id, nil)
    change_column_default(:staff_accounts, :user_id, nil)
  end
end
