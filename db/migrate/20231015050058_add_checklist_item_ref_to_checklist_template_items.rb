class AddChecklistItemRefToChecklistTemplateItems < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :checklist_template_items, :checklist_item, null: false, default: 0, index: {algorithm: :concurrently}
  end
end
