class CreateLocationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :adopter_profile, null: false, foreign_key: true, index: { unique: true }
      t.string :country
      t.string :city_town
      t.string :province_state
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
