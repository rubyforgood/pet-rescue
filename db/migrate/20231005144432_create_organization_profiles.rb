class CreateOrganizationProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :organization_profiles do |t|
      t.string :email
      t.string :phone_number

      t.references :location, index: true, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :organization_profiles
  end
end
