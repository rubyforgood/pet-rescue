class CreateAdopterFosterAccounts < ActiveRecord::Migration[7.0]
  def change
<<<<<<< HEAD
    unless table_exists?(:adopter_foster_accounts)
      create_table :adopter_foster_accounts do |t|
        t.references :user, null: false, foreign_key: true
        t.timestamps
      end
=======
    create_table :adopter_foster_accounts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
>>>>>>> 610a426 (Update with AdopterFosterAccount files)
    end
  end
end
