# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text
#  help_text   :text
#  input_type  :string           default("short"), not null
#  label       :string           not null
#  name        :string           not null
#  options     :json
#  required    :boolean          default(FALSE), not null
#  sort_order  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  form_id     :bigint           not null
#
# Indexes
#
#  index_questions_on_form_id            (form_id)
#  index_questions_on_form_id_and_label  (form_id,label) UNIQUE
#  index_questions_on_form_id_and_name   (form_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class Question < ApplicationRecord
  belongs_to :form

  has_one :organization, through: :form

  scope :ordered, -> { order(:sort_order) }

  validates_presence_of :name, :label

  def snapshot
    {label:, options:}
  end
end
