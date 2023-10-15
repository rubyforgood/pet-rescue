# == Schema Information
#
# Table name: checklist_items
#
#  id          :bigint           not null, primary key
#  description :text
#  input_type  :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ChecklistItem < ApplicationRecord
  has_many :items, class_name: "ChecklistTemplateItem", dependent: :destroy

  enum :input_type, %i[str int date bool]
end
