class CreateFosterAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :foster_accounts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
