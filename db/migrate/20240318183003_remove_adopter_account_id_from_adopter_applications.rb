class RemoveAdopterAccountIdFromAdopterApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :adopter_applications, :adopter_account_id, :bigint
  end
end
