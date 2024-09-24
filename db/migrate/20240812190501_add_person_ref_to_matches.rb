class AddPersonRefToMatches < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_reference :matches, :person, index: {algorithm: :concurrently}
  end
end
