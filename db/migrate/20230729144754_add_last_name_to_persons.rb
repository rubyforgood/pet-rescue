class AddLastNameToPersons < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :last_name, :string
  end
end
