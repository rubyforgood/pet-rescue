class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.timestamps
    end
  end
end
