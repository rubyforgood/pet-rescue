class CreateChecklistItems < ActiveRecord::Migration[7.0]
  def change
    create_table :checklist_items do |t|
      t.string :name
      t.text :description
      t.integer :input_type

      t.timestamps
    end
  end
end
