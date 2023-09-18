class CreateChecklistTemplateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :checklist_template_items do |t|
      t.references :checklist_template, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :expected_duration_days, null: false
      t.boolean :required, null: false

      t.timestamps
    end
  end
end
