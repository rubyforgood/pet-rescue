class CreateLikedPets < ActiveRecord::Migration[7.1]
  def change
    create_table :liked_pets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end

    add_index :liked_pets, [:user_id, :pet_id], unique: true
  end
end
