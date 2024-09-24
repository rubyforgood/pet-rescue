class RemoveNameFromPeople < ActiveRecord::Migration[7.1]
  def change
    safety_assured { remove_column :people, :name, null: false }
  end
end
