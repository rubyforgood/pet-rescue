class CreateFosterAccounts < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:foster_accounts)
      create_table :foster_accounts do |t|
        t.references :user, null: false, foreign_key: true

        t.timestamps
      end
    end
  end
end
