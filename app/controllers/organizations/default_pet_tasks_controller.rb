class Organizations::DefaultPetTasksController < Organizations::BaseController
  layout "dashboard"

  def index
    @default_pet_tasks = DefaultPetTask.all
  end

end
