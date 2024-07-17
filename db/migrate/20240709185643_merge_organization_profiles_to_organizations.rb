class MergeOrganizationProfilesToOrganizations < ActiveRecord::Migration[7.1]
  def up
    add_column :organizations, :email, :string
    add_column :organizations, :phone_number, :string
    add_column :organizations, :donation_url, :text
    add_column :organizations, :facebook_url, :text
    add_column :organizations, :instagram_url, :text
    add_reference :organizations, :location, foreign_key: true

    execute <<-SQL
      UPDATE organizations o
      SET 
        location_id = op.location_id,
        email = op.email,
        phone_number = op.phone_number,
        facebook_url = op.facebook_url,
        instagram_url = op.instagram_url,
        donation_url = op.donation_url
      FROM organization_profiles op
      WHERE op.organization_id = o.id
    SQL

    change_column_null :organizations, :location_id, false
  end

  def down
    remove_reference :organizations, :location
    remove_column :organizations, :donation_url
    remove_column :organizations, :email
    remove_column :organizations, :facebook_url
    remove_column :organizations, :instagram_url
    remove_column :organizations, :phone_number
  end
end
