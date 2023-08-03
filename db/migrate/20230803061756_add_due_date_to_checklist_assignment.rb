class AddDueDateToChecklistAssignment < ActiveRecord::Migration[7.0]
  def change
    add_column :checklist_assignments, :due_date, :datetime, null: false
  end
end
