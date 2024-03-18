class AddAdopterFosterAccountIdToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :adopter_foster_account_id, :bigint
    add_index :matches, :adopter_foster_account_id
  end
end
