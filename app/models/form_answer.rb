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
#  person_id          :bigint           not null
#  question_id        :bigint
#
# Indexes
#
#  index_form_answers_on_form_submission_id  (form_submission_id)
#  index_form_answers_on_organization_id     (organization_id)
#  index_form_answers_on_person_id           (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_submission_id => form_submissions.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (question_id => questions.id)
#
class FormAnswer < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :person
  belongs_to :form_submission
end
