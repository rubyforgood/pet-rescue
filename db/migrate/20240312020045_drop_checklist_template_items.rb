class DropChecklistTemplateItems < ActiveRecord::Migration[7.0]
  def change
    drop_table :checklist_template_items
  end
end
