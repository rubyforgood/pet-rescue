class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :string_value
      t.integer :integer_value
      t.boolean :boolean_value
      t.text :array_value, array: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
