class RemoveNameFromPets < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :name, :string
  end
end
