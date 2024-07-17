# == Schema Information
#
# Table name: task_templates
#
#  id              :bigint           not null, primary key
#  description     :string
#  due_in_days     :integer
#  name            :string           not null
#  recurring       :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_task_templates_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class TaskTemplate < ApplicationRecord
  acts_as_tenant(:organization)

  validates :name, presence: true
  validates_numericality_of :due_in_days, only_integer: true, greater_than_or_equal_to: 0, allow_nil: true
end
