class CreateDefaultPetTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :default_pet_tasks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
