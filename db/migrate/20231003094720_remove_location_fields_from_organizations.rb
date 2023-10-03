class RemoveLocationFieldsFromOrganizations < ActiveRecord::Migration[7.0]
  def up
    safety_assured do
      remove_column :organizations, :city, :string
      remove_column :organizations, :country, :string
      remove_column :organizations, :zipcode, :string
    end
  end
  
  def down
    add_column :organizations, :city, :string
    add_column :organizations, :country, :string
    add_column :organizations, :zipcode, :string
  end
end