class Organizations::TaskService
  def initialize(task)
    @task = task
  end

  def create_next
    Task.create(
      pet_id: @task.pet_id,
      name: @task.name,
      description: @task.description,
      recurring: true,
      next_due_date_in_days: @task.next_due_date_in_days,
      due_date: next_due_date
    )
  end

  private

  def next_due_date
    return nil unless @task.due_date

    if overdue?
      @task.updated_at + @task.next_due_date_in_days.days
    else
      @task.due_date + @task.next_due_date_in_days.days
    end
  end

  def overdue?
    @task.due_date < @task.updated_at
  end
end
