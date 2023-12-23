# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  completed   :boolean
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pet_id      :bigint           not null
#
# Indexes
#
#  index_tasks_on_pet_id  (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (pet_id => pets.id)
#
class Task < ApplicationRecord
  belongs_to :pet

  validates :name, presence: true
  validates :description, presence: true
end
