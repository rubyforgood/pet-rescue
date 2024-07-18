class ChangeLocationAssociation < ActiveRecord::Migration[7.1]
  def up
    add_reference :locations, :organization, foreign_key: true

    execute <<-SQL
      UPDATE locations
      SET organization_id = op.organization_id
      FROM organization_profiles op
      WHERE locations.id = op.location_id
    SQL
  end

  def down
    remove_reference :locations, :organization
  end
end
