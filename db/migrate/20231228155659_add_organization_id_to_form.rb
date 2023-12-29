class AddOrganizationIdToForm < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :forms, :organization, index: {algorithm: :concurrently}
  end
end
