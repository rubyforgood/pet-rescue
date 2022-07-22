class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :adopter_account, null: false, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
