module PetTaskable
  extend ActiveSupport::Concern

  included do
    scope :with_overdue_tasks, -> {
      left_joins(:tasks)
        .select("pets.*, COUNT(tasks.id) AS incomplete_tasks_count")
        .where(tasks: {completed: false})
        .where("tasks.due_date < ?", Time.current)
        .group("pets.id")
    }

    scope :with_incomplete_tasks, -> {
      left_joins(:tasks)
        .select("pets.*, COUNT(tasks.id) AS incomplete_tasks_count")
        .where(tasks: {completed: false})
        .where("tasks.due_date IS NULL OR tasks.due_date >= ?", Time.current)
        .group("pets.id")
    }
  end
end
