# == Schema Information
#
# Table name: submitted_answers
#
#  id                 :bigint           not null, primary key
#  question_snapshot  :json             not null
#  value              :json             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  form_submission_id :bigint           not null
#  question_id        :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_submitted_answers_on_form_submission_id  (form_submission_id)
#  index_submitted_answers_on_question_id         (question_id)
#  index_submitted_answers_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_submission_id => form_submissions.id)
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
module CustomForm
  class SubmittedAnswer < ApplicationRecord
    belongs_to :question
    belongs_to :user
    belongs_to :form_submission

    has_one :form, class_name: "CustomForm::Form", through: :question
    has_one :organization, through: :form
  end
end
