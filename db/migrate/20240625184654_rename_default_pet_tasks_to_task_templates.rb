class RenameDefaultPetTasksToTaskTemplates < ActiveRecord::Migration[7.1]
  def change
    rename_table :default_pet_tasks, :task_templates
  end
end
