class RemoveUniqueIndexOnPetName < ActiveRecord::Migration[7.0]
  def change
    remove_index :pets, :name
  end
end
