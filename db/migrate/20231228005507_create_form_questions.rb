class CreateFormQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :form_questions do |t|
      t.references :form, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
