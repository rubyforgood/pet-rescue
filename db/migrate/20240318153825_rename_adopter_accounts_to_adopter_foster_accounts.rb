class RenameAdopterAccountsToAdopterFosterAccounts < ActiveRecord::Migration[7.0]
  def change
    rename_table :adopter_accounts, :adopter_foster_accounts
  end
end
