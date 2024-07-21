class UpdateAdminRoleNames < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      UPDATE roles
      SET name = 'super_admin'
      WHERE name = 'admin';
    SQL

    execute <<-SQL
      UPDATE roles
      SET name = 'admin'
      WHERE name = 'staff';
    SQL
  end

  def down
    execute <<-SQL
      UPDATE roles
      SET name = 'admin'
      WHERE name = 'super_admin';
    SQL

    execute <<-SQL
      UPDATE roles
      SET name = 'staff'
      WHERE name = 'admin';
    SQL
  end
end
