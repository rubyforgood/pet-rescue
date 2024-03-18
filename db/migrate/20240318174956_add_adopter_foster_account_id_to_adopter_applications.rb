class AddAdopterFosterAccountIdToAdopterApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :adopter_applications, :adopter_foster_account_id, :bigint
    add_index :adopter_applications, :adopter_foster_account_id
  end
end
