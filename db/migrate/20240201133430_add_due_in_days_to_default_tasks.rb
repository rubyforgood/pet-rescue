class AddDueInDaysToDefaultTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :default_pet_tasks, :due_in_days, :integer, null: true
  end
end
