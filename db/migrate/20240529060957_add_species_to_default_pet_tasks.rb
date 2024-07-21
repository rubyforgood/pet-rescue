class AddSpeciesToDefaultPetTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :default_pet_tasks, :species, :integer
  end
end
