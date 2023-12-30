# == Schema Information
#
# Table name: forms
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_forms_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Form < ApplicationRecord
  has_many :form_questions, dependent: :destroy
  has_many :questions, through: :form_questions
  has_many :submissions, dependent: :destroy

  acts_as_tenant(:organization)
end
