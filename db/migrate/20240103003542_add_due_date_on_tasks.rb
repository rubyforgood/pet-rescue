class AddDueDateOnTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :due_date, :datetime, index: true
  end
end
