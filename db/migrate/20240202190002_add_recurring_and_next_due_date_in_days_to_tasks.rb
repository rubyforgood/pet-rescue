class AddRecurringAndNextDueDateInDaysToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :recurring, :boolean, default: false
    add_column :tasks, :next_due_date_in_days, :integer
  end
end
