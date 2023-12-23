# Service object that creates the default pet tasks for a newly created Pet
class Organizations::DefaultPetTaskService
  def initialize(pet)
    @pet = pet
    @default_pet_tasks = DefaultPetTask.all
  end

  def default_tasks_array
    @default_pet_tasks.map do |task|
      {
        pet_id: @pet.id,
        name: task.name,
        description: task.description,
        completed: false
      }
    end
  end

  def create_tasks
    ActiveRecord::Base.transaction do
      Task.create(default_tasks_array)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.info "Error creating tasks: #{e.message}"
    end
  end
end
