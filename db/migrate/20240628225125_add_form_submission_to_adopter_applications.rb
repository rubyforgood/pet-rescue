class AddFormSubmissionToAdopterApplications < ActiveRecord::Migration[7.1]
  def change
    add_reference :adopter_applications, :form_submission, null: false, foreign_key: true
  end
end
