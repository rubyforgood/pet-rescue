class RemoveAdopterAccountIdFromMatches < ActiveRecord::Migration[7.0]
  def change
    remove_column :matches, :adopter_account_id, :bigint
  end
end
