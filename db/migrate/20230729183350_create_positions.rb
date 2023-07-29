class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.references :organization
      t.references :staff_account
      t.timestamps
    end
  end
end
