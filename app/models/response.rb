# == Schema Information
#
# Table name: responses
#
#  id              :bigint           not null, primary key
#  array_value     :text             is an Array
#  boolean_value   :boolean
#  date_value      :date
#  integer_value   :integer
#  string_value    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  question_id     :bigint           not null
#  submission_id   :bigint           not null
#
# Indexes
#
#  index_responses_on_organization_id  (organization_id)
#  index_responses_on_question_id      (question_id)
#  index_responses_on_submission_id    (submission_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (submission_id => submissions.id)
#
class Response < ApplicationRecord
  belongs_to :question
  belongs_to :submission

  acts_as_tenant(:organization)
end
