class CreateCustomForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :name, null: false
      t.text :description
      t.string :title, null: false
      t.text :instructions

      t.references :organization, foreign_key: true, null: false

      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :forms, [:organization_id, :name], unique: true
    add_index :forms, [:organization_id, :title], unique: true

    create_table :form_profiles do |t|
      t.references :form, foreign_key: true, null: false

      t.string :profile_type, null: false
      t.integer :sort_order, null: false, default: 0
    end

    add_index :form_profiles, [:form_id, :profile_type], unique: true

    create_table :questions do |t|
      t.string :name, null: false
      t.text :description
      t.string :label, null: false
      t.text :help_text
      t.string :input_type, null: false, default: "short"
      t.boolean :required, null: false, default: false
      t.json :options
      t.integer :sort_order, null: false, default: 0

      t.references :form, foreign_key: true, null: false

      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :questions, [:form_id, :name], unique: true
    add_index :questions, [:form_id, :label], unique: true

    create_table :answers do |t|
      t.json :value, null: false
      t.json :question_snapshot, null: false

      t.references :question, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
