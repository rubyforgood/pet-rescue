class Organizations::TasksController < Organizations::BaseController
  verify_authorized

  before_action :set_pet, only: %i[new create edit update destroy]
  before_action :set_task, only: %i[edit update destroy]

  def new
    authorize! Task, context: {pet: @pet}

    @task = @pet.tasks.build
  end

  def create
    authorize! Task, context: {pet: @pet}

    @task = @pet.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "organizations/pets/tasks/tasks", locals: {task: @task}) }
        format.html { redirect_to pet_url(@pet, active_tab: "tasks") }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "organizations/pets/tasks/form", locals: {task: @task, url: pet_tasks_path(@task.pet)}), status: :bad_request }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "organizations/pets/tasks/tasks", locals: {task: @task}) }
        format.html { redirect_to pet_url(@pet, active_tab: "tasks") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "organizations/pets/tasks/form", locals: {task: @task, url: pet_task_path(@task.pet)}), status: :bad_request }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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

    @pet = @organization.pets.find(params[:pet_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path unless @pet
  end

  def set_task
    @task = Task.find(params[:id])
    authorize! @task
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path
  end

  def task_params
    params.require(:task).permit(:name, :description, :completed, :due_date)
  end
end
