class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
