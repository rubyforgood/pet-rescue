class Organizations::DefaultPetTasksController < Organizations::BaseController
  verify_authorized

  layout "dashboard"

  before_action :verify_organization_for_current_user

  def index
    @default_pet_tasks = DefaultPetTask.all
  end

  def new
    @task = DefaultPetTask.new
  end

  def create
    @task = DefaultPetTask.new(task_params)

    if @task.save
      redirect_to default_pet_tasks_path, notice: "Default pet task saved successfully."
    else
      flash.now[:alert] = "Error creating default pet task."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = DefaultPetTask.find(params[:id])
  end

  def update
    @task = DefaultPetTask.find(params[:id])

    if @task.update(task_params)
      redirect_to default_pet_tasks_path, notice: "Default pet task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = DefaultPetTask.find(params[:id])
    @task.destroy

    redirect_to default_pet_tasks_path, notice: "Default pet task was successfully deleted."
  rescue ActiveRecord::RecordNotFound
    redirect_to default_pet_tasks_path, alert: "Failed to delete default pet task."
  end

  private

  def task_params
    params.require(:default_pet_task).permit(:name, :description, :due_in_days)
  end
end
