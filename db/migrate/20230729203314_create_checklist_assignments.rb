class CreateChecklistAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :checklist_assignments do |t|
      t.references :checklist_template_item, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
