class AddFormSubmissionToSubmittedAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :submitted_answers, :form_submission, null: false, foreign_key: true
  end
end
