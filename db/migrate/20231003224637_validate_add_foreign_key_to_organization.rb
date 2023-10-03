class ValidateAddForeignKeyToOrganization < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :organizations, :locations
  end
end

