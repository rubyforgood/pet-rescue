class Organizations::TasksController < Organizations::BaseController
  before_action :set_pet, only: [:new, :create, :edit, :update, :destroy]

  def create
    @task = @pet.tasks.build(task_params)
    if @task.save
      redirect_to @pet
    else
      render :new
    end
    puts params.inspect
  end

  def edit
    @task = @pet.tasks.find(params[:id])
  end

  def update
    @task = @pet.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to @pet
    else
      render :edit
    end
  end

  def destroy
    @task = @pet.tasks.find(params[:id])
    @task.destroy
    redirect_to @pet
  end

  def new
    @task = @pet.tasks.build
    render partial: "nice_partials/new_task_form"
  end

  private

  def set_pet
    @organization = Organization.find_by(slug: "alta")
    raise ActiveRecord::RecordNotFound if @organization.nil?
    pet_id = params[:pet_id] || params[:id]
    @pet = @organization.pets.find(pet_id)
  end

  def task_params
    params.require(:task).permit(:name, :description, :completed)
  end
end
