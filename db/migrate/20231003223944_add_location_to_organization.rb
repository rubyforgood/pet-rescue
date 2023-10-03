class AddLocationToOrganization < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def up
    add_reference :organizations, :location, index: { algorithm: :concurrently }
  end

  def down
    remove_reference :organizations, :location
  end
end

