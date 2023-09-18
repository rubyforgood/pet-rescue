class AddOrganizationIdToMatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :organization, null: false
  end
end
