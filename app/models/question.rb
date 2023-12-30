# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  input_type      :integer          default("string")
#  text            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_questions_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Question < ApplicationRecord
  enum input_type: [:string, :boolean, :integer, :array]

  has_many :form_questions, dependent: :destroy
  has_many :forms, through: :form_questions
  has_many :responses, dependent: :destroy

  validates :text, presence: true
  validates :input_type, presence: true

  acts_as_tenant(:organization)
end
