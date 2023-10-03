class AddForeignKeyToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :organizations, :locations, validate: false
  end
end