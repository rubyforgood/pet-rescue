class DropChecklistTemplates < ActiveRecord::Migration[7.0]
  def change
    drop_table :checklist_templates
  end
end
