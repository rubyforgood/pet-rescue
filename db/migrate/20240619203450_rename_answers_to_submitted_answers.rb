class RenameAnswersToSubmittedAnswers < ActiveRecord::Migration[7.1]
  def change
    rename_table :answers, :submitted_answers
  end
end
