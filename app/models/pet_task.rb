# A plain object that creates the default pet tasks for newly created Pet
class PetTask
  def initialize(pet)
    @pet = pet
    @default_pet_tasks = DefaultPetTask.all
  end

  def create
    ActiveRecord::Base.transaction do
      @default_pet_tasks.each do |task|
        Task.create!(
          pet_id: @pet.id,
          name: task.name,
          description: task.description,
          completed: false
        )
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Error creating tasks: #{e.message}"
  end
end
