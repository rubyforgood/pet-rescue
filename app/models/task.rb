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
  validate :next_due_date_when_sensible

  default_scope { order(created_at: :asc) }

  private

  def next_due_date_when_sensible
    if next_due_date_in_days && (!due_date || !recurring)
      errors.add(:base, "A task must be recurring and have a due date in order to set next due date in days value.")
    elsif !next_due_date_in_days && (recurring && due_date)
      errors.add(:base, "Recurring tasks with due dates must set a next due date in days value.")
    end
  end
end
