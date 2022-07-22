class CreateAdopterProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :adopter_profiles do |t|
      t.references :adopter_account, null: false, foreign_key: true
      t.string :city
      t.string :country
      t.string :experience
      t.timestamps
    end
  end
end
