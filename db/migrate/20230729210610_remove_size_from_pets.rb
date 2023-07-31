class RemoveSizeFromPets < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :size, :string
  end
end
