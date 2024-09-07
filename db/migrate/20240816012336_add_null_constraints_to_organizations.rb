class AddNullConstraintsToOrganizations < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      change_column_null :organizations, :name, false
      change_column_null :organizations, :slug, false
      change_column_null :organizations, :email, false
    end
  end
end
