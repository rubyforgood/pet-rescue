class Organizations::DefaultPetTasksController < Organizations::BaseController
  layout "dashboard"

  before_action :set_organization, only: [:new, :create, :edit, :update, :destroy]

  def index
    @default_pet_tasks = DefaultPetTask.all
  end

  def new
    @task = @organization.default_pet_tasks.build
  end

  def create
    @task = @organization.default_pet_tasks.build(task_params)

    if @task.save
      redirect_to default_pet_tasks_path, notice: "Default pet task saved successfully."
    else
      flash.now[:alert] = "Error creating default pet task."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = @organization.default_pet_tasks.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound if @task.nil?
  end

  def update
    @task = @organization.default_pet_tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to default_pet_tasks_path, notice: "Default pet task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = @organization.default_pet_tasks.find(params[:id])
    @task.destroy

    redirect_to default_pet_tasks_path, notice: "Default pet task was successfully deleted."
  rescue ActiveRecord::RecordNotFound
    redirect_to default_pet_tasks_path, alert: "Failed to delete default pet task."
  end

  private

  def set_organization
    @organization = current_user.organization
    raise ActiveRecord::RecordNotFound if @organization.nil?
  end

  def task_params
    params.require(:default_pet_task).permit(:name, :description)
  end
end
