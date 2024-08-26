class RemoveUniqueConstraintPetIndexInMatches < ActiveRecord::Migration[7.1]
  def change
    remove_index :matches, column: :pet_id, unique: true
    add_index :matches, :pet_id
  end
end
