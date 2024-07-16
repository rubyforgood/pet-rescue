# == Schema Information
#
# Table name: form_answers
#
#  id                 :bigint           not null, primary key
#  question_snapshot  :json             not null
#  value              :json             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  form_submission_id :bigint           not null
#  organization_id    :bigint           not null
#  question_id        :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_form_answers_on_form_submission_id  (form_submission_id)
#  index_form_answers_on_organization_id     (organization_id)
#  index_form_answers_on_question_id         (question_id)
#  index_form_answers_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_submission_id => form_submissions.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
class FormAnswer < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :user
  belongs_to :form_submission
end
