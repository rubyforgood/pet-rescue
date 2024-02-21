# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  completed   :boolean
#  description :text
#  due_date    :datetime
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

  scope :is_not_completed, -> { where(completed: false).or(where(completed: nil)) }
  scope :is_completed, -> { where(completed: true) }
  scope :has_due_date, -> { where.not(due_date: nil).order(due_date: :asc) }
  scope :no_due_date, -> { where(due_date: nil).order(updated_at: :desc) }

  def overdue?
    due_date < Time.current if due_date
  end

  def self.list_ordered
    Task.is_not_completed.has_due_date +
      Task.is_not_completed.no_due_date +
      Task.is_completed.has_due_date +
      Task.is_completed.no_due_date
  end
end
