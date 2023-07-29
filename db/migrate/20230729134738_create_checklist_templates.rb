class CreateChecklistTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :checklist_templates do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
