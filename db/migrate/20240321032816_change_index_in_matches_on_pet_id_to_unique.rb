class ChangeIndexInMatchesOnPetIdToUnique < ActiveRecord::Migration[7.0]
  def change
    remove_index :matches, :pet_id
    add_index :matches, :pet_id, unique: true
  end
end
