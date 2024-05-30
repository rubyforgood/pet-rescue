class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :adopter_foster_account, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, [:adopter_foster_account_id, :pet_id], unique: true
  end
end
