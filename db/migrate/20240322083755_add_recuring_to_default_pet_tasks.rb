class AddRecuringToDefaultPetTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :default_pet_tasks, :recurring, :boolean, default: false
  end
end
