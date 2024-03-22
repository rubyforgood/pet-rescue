class Organizations::DefaultPetTasksController < Organizations::BaseController
  before_action :context_authorize!, only: %i[index new create]
  before_action :set_task, only: %i[edit update destroy]

  layout "dashboard"

  def index
    @default_pet_tasks = authorized_scope(DefaultPetTask.all)
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
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to default_pet_tasks_path, notice: "Default pet task updated successfully." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("default_pet_task_#{@task.id}", partial: "recurring", locals: {task: @task}) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to default_pet_tasks_path, notice: "Default pet task was successfully deleted."
  end

  private

  def task_params
    params.require(:default_pet_task).permit(:name, :description, :due_in_days, :recurring)
  end

  def set_task
    @task = DefaultPetTask.find(params[:id])

    authorize! @task
  rescue ActiveRecord::RecordNotFound
    redirect_to default_pet_tasks_path, alert: "Default Pet Task not found."
  end

  def context_authorize!
    authorize! DefaultPetTask,
      context: {organization: Current.organization}
  end
end
