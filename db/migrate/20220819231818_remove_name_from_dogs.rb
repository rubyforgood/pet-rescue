class RemoveNameFromDogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :dogs, :name, :string
  end
end
