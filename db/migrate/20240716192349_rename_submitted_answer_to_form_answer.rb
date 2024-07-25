class RenameSubmittedAnswerToFormAnswer < ActiveRecord::Migration[7.1]
  def change
    rename_table :submitted_answers, :form_answers
  end
end
