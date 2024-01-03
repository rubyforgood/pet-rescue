class RemoveLocationFieldsFromOrganizations < ActiveRecord::Migration[7.0]
  def up
    remove_column :organizations, :city, :string
    remove_column :organizations, :country, :string
    remove_column :organizations, :zipcode, :string
  end

  def down
    add_column :organizations, :city, :string
    add_column :organizations, :country, :string
    add_column :organizations, :zipcode, :string
  end
end
