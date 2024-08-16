class AddNullConstraintsToOrganizations < ActiveRecord::Migration[7.1]
  def change
    # Adding check constraints to ensure the columns are not null without locking the table
    add_check_constraint :organizations, "name IS NOT NULL", name: "organizations_name_null", validate: false
    add_check_constraint :organizations, "slug IS NOT NULL", name: "organizations_slug_null", validate: false
    add_check_constraint :organizations, "email IS NOT NULL", name: "organizations_email_null", validate: false
  end
end
