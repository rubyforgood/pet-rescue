class AddFirstNameToPersons < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :first_name, :string
  end
end
