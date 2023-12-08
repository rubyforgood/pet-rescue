class AddNullConstraintToNameInTasks < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :tasks, "name IS NOT NULL", name: "tasks_name_null", validate: false
  end
end
