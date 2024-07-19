class RemovePersonFromFormAnswers < ActiveRecord::Migration[7.1]
  def change
    remove_index :form_answers, :person_id
    remove_column :form_answers, :person_id
  end
end
