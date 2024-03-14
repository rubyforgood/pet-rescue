class DropChecklistAssignments < ActiveRecord::Migration[7.0]
  def change
    drop_table :checklist_assignments
  end
end
