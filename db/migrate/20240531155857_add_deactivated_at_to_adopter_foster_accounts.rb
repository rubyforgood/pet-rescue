class AddDeactivatedAtToAdopterFosterAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :adopter_foster_accounts, :deactivated_at, :datetime
  end
end
