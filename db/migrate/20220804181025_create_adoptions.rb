class CreateAdoptions < ActiveRecord::Migration[7.0]
  def change
    create_table :adoptions do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :adopter_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
