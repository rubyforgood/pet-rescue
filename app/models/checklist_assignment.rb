# == Schema Information
#
# Table name: checklist_assignments
#
#  id                         :bigint           not null, primary key
#  completed_at               :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  checklist_template_item_id :bigint           not null
#  match_id                   :bigint           not null
#
# Indexes
#
#  index_checklist_assignments_on_checklist_template_item_id  (checklist_template_item_id)
#  index_checklist_assignments_on_match_id                    (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (checklist_template_item_id => checklist_template_items.id)
#  fk_rails_...  (match_id => matches.id)
#
class ChecklistAssignment < ApplicationRecord
  belongs_to :checklist_template_item
  belongs_to :match

  # scope :completed, -> { where.not(completed_at: nil)}
  # scope :incomplete, -> {where(completed_at: nil)}

  # def completed?
  #   completed_at
  # end 
end
