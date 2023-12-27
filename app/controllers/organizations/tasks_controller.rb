class Organizations::TasksController < Organizations::BaseController
  before_action :set_pet, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update]

  def new
    @task = @pet.tasks.build
  end

  def create
    @task = @pet.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "organizations/pets/tasks/tasks", locals: {task: @task}) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "organizations/tasks/form", locals: {task: @task}) }
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "organizations/pets/tasks/tasks", locals: {task: @task}) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "organizations/pets/tasks/form", locals: {task: @task}) }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to pet_path(@pet), notice: "Task was successfully deleted." }
      format.turbo_stream
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path
  end

  private

  def set_pet
    @organization = current_user.organization
    raise ActiveRecord::RecordNotFound if @organization.nil?

    pet_id = params[:pet_id] || params[:id]
    @pet = @organization.pets.find(pet_id)
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path unless @pet
  end

  def set_task
    @task = @pet.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path
  end

  def task_params
    params.require(:task).permit(:name, :description, :completed)
  end
end
