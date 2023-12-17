class CreateDefaultPetTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :default_pet_tasks do |t|
      t.bigint :organization_id, null: false
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
