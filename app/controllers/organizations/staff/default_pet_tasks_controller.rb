class Organizations::Staff::DefaultPetTasksController < Organizations::BaseController
  before_action :context_authorize!, only: %i[index new create]
  before_action :set_task, only: %i[edit update destroy]
  include ::Pagy::Backend

  layout "dashboard"

  def index 
    ensure_due_in_days_in_q_params

    @default_pet_tasks = authorized_scope(DefaultPetTask.all)

    apply_species_filter
    apply_recurring_filter
    apply_due_in_days_filter

    @q = @default_pet_tasks.ransack(params[:q])
    @default_pet_tasks = @q.result

    @pagy, @default_pet_tasks = pagy(@default_pet_tasks, items: 10)
    @partial_to_render = params[:q].present? ? "search_results" : "default_pet_tasks_table"
  end

  def new
    @task = DefaultPetTask.new
  end

  def create
    @task = DefaultPetTask.new(task_params)

    if @task.save
      redirect_to staff_default_pet_tasks_path, notice: t(".success")
    else
      flash.now[:alert] = t(".error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to staff_default_pet_tasks_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to staff_default_pet_tasks_path, notice: t(".success")
  end

  private

  def task_params
    params.require(:default_pet_task).permit(:name, :description, :due_in_days, :species, :recurring)
  end

  def set_task
    @task = DefaultPetTask.find(params[:id])

    authorize! @task
  rescue ActiveRecord::RecordNotFound
    redirect_to staff_default_pet_tasks_path, alert: t(".error")
  end

  def context_authorize!
    authorize! DefaultPetTask,
      context: {organization: Current.organization}
  end

  def ensure_due_in_days_in_q_params
    if params[:due_in_days].present?
      params[:q] ||= {}
      params[:q]["due_in_days"] = params[:due_in_days]
    end
  end

  def apply_species_filter
    if params[:q].present? && params[:q]["species_eq"].present?
      species_filter = params[:q]["species_eq"]
      params[:q]["species_eq"] = Pet.species[species_filter] if Pet.species.key?(species_filter)
    end
  end

  def apply_recurring_filter
    if params[:q].present? && params[:q]["recurring"].present?
      if params[:q]["recurring"] == "true"
        @default_pet_tasks = @default_pet_tasks.where(recurring: true)
      elsif params[:q]["recurring"] == "false"
        @default_pet_tasks = @default_pet_tasks.where(recurring: false)
      end
    end
  end

  def apply_due_in_days_filter
    if params[:q].present? && params[:q]["due_in_days"].present?
      @default_pet_tasks = @default_pet_tasks.where("due_in_days >= ?", params[:q]["due_in_days"].to_i)
    end
  end
end
