class CreateWeightsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :weights do |t|
      t.references :pet, null: false, foreign_key: true
      t.integer :from
      t.integer :to
      t.string :unit
      t.timestamps
    end
  end
end
