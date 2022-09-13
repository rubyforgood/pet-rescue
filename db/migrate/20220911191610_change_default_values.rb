class ChangeDefaultValues < ActiveRecord::Migration[7.0]
  def change
    change_column_default :adopter_accounts, :user_id, default: 0
    change_column_default :staff_accounts, :user_id, default: 0
  end
end
