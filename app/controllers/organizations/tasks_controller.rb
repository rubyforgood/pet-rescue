class Organizations::TasksController < Organizations::BaseController
  before_action :set_pet, only: [:new, :create, :edit, :update]
  before_action :set_task, only: [:edit, :update]

  def new
    @task = @pet.tasks.build
    render partial: "nice_partials/new_task_form"
  end

  def create
    @task = @pet.tasks.build(task_params)
    if @task.save
      redirect_to pet_path(@pet, active_tab: @active_tab) # Make sure @active_tab is set elsewhere or provide a default
    else
      render :new
    end
  end

  def edit
    render layout: false
    @task = @pet.tasks.build
    respond_to do |format|
      format.html # default behavior
      format.js
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @pet
    else
      render :edit
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
