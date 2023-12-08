class ValidateAddNullConstraintToNameInTasks < ActiveRecord::Migration[7.0]
  def up
    validate_check_constraint :tasks, name: "tasks_name_null"
    change_column_null :tasks, :name, false
    remove_check_constraint :tasks, name: "tasks_name_null"
  end

  def down
    add_check_constraint :tasks, "name IS NOT NULL", name: "tasks_name_null", validate: false
    change_column_null :tasks, :name, true
  end
end
