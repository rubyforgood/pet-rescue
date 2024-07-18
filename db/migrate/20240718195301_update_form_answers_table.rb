class UpdateFormAnswersTable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :form_answers, :question_id, true

    remove_index :form_answers, :user_id
    remove_column :form_answers, :user_id

    remove_index :form_answers, :question_id
  end
end
