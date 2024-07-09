# == Schema Information
#
# Table name: form_submissions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  person_id       :bigint           not null
#
# Indexes
#
#  index_form_submissions_on_organization_id  (organization_id)
#  index_form_submissions_on_person_id        (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (person_id => people.id)
#

class FormSubmission < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :person

  has_many :adopter_applications
  has_many :submitted_answers, class_name: "CustomForm::SubmittedAnswer"
end
