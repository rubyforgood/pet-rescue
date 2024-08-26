# Service object that creates the default pet tasks for a newly created Pet
class Organizations::DefaultPetTaskService
  def initialize(pet)
    @pet = pet
    @default_pet_tasks = DefaultPetTask.where(species: DefaultPetTask.species.values_at("All", pet.species))
  end

  def default_tasks_array
    @default_pet_tasks.map do |task|
      {
        pet_id: @pet.id,
        name: task.name,
        description: task.description,
        completed: false,
        due_date: task.due_in_days&.days&.from_now&.beginning_of_day,
        recurring: task.recurring,
        next_due_date_in_days: task.recurring? ? task.due_in_days : nil
      }
    end
  end

  # no error handling as errors should bubble up to where this method is called
  def create_tasks
    ActiveRecord::Base.transaction do
      Task.create!(default_tasks_array)
    end
  end
end
