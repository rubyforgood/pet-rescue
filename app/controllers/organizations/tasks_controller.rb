class Organizations::TasksController < Organizations::BaseController
  before_action :set_pet, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update]

  def new
    @task = @pet.tasks.build
    render partial: "form", locals: {task: @task}
  end

  def create
    @task = @pet.tasks.build(task_params)
    if @task.save
      redirect_to pet_path(@pet, active_tab: @active_tab)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "organizations/tasks/tasks", locals: {task: @task}) }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to pet_path(@pet), notice: "Task was successfully deleted."
  end

  private

  def set_pet
    @organization = Organization.find_by(slug: "alta")
    raise ActiveRecord::RecordNotFound if @organization.nil?

    pet_id = params[:pet_id] || params[:id]
    @pet = @organization.pets.find(pet_id)
  end

  def set_task
    @task = @pet.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :completed)
  end
end
