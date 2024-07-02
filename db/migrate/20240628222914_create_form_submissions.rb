class CreateFormSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :form_submissions do |t|
      t.references :person, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
