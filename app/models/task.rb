# == Schema Information
#
# Table name: tasks
#
#  id                    :bigint           not null, primary key
#  completed             :boolean          default(FALSE)
#  description           :text
#  due_date              :datetime
#  name                  :string           not null
#  next_due_date_in_days :integer
#  recurring             :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  pet_id                :bigint           not null
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
  validates :next_due_date_in_days, numericality: {only_integer: true, allow_nil: true}

  default_scope { order(created_at: :asc) }
end
