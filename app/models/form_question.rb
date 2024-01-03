# == Schema Information
#
# Table name: form_questions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  form_id         :bigint           not null
#  organization_id :bigint           not null
#  question_id     :bigint           not null
#
# Indexes
#
#  index_form_questions_on_form_id          (form_id)
#  index_form_questions_on_organization_id  (organization_id)
#  index_form_questions_on_question_id      (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (question_id => questions.id)
#
class FormQuestion < ApplicationRecord
  belongs_to :form
  belongs_to :question

  acts_as_tenant(:organization)
end
