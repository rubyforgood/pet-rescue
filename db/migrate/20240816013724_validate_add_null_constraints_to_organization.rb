class ValidateAddNullConstraintsToOrganization < ActiveRecord::Migration[7.1]
  def up
    validate_check_constraint :organizations, name: "organizations_name_null"
    validate_check_constraint :organizations, name: "organizations_slug_null"
    validate_check_constraint :organizations, name: "organizations_email_null"

    change_column_null :organizations, :name, false
    change_column_null :organizations, :slug, false
    change_column_null :organizations, :email, false

    remove_check_constraint :organizations, name: "organizations_name_null"
    remove_check_constraint :organizations, name: "organizations_slug_null"
    remove_check_constraint :organizations, name: "organizations_email_null"
  end

  def down
    add_check_constraint :organizations, "name IS NOT NULL", name: "organizations_name_null", validate: false
    add_check_constraint :organizations, "slug IS NOT NULL", name: "organizations_slug_null", validate: false
    add_check_constraint :organizations, "email IS NOT NULL", name: "organizations_email_null", validate: false

    change_column_null :organizations, :name, true
    change_column_null :organizations, :slug, true
    change_column_null :organizations, :email, true
  end
end
