# == Schema Information
#
# Table name: checklist_templates
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ChecklistTemplate < ApplicationRecord
end
