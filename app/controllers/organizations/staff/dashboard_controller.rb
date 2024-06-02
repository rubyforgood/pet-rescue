class Organizations::Staff::DashboardController < Organizations::BaseController
  before_action :context_authorize!, only: %i[index incomplete_tasks overdue_tasks]
  include Pagy::Backend
  layout "dashboard"

  def index
    @user = current_user
    @organization = Current.organization
    @hide_footer = true
    @not_completed_not_overdue_tasks_count = Task.is_not_completed.not_overdue.count
    @not_completed_overdue_tasks_count = Task.is_not_completed.overdue.count
  end

  def incomplete_tasks
    @organization = Current.organization
    @pagy, @pets = pagy(
      Pet
      .left_joins(:tasks)
      .select("pets.*, COUNT(tasks.id) AS incomplete_tasks_count")
      .where(tasks: {completed: false})
      .where("tasks.due_date IS NULL OR tasks.due_date >= ?", Time.current)
      .group("pets.id"),
      items: 5
    )
    @column_name = "Incomplete Tasks"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("tasks-frame", partial: "organizations/staff/dashboard/tasks", locals: {column_name: @column_name})
      end
      format.html { render :tasks, locals: {column_name: @column_name} }
    end
  end

  def overdue_tasks
    @organization = Current.organization
    @pagy, @pets = pagy(
      Pet
      .left_joins(:tasks)
      .select("pets.*, COUNT(tasks.id) AS incomplete_tasks_count")
      .where(tasks: {completed: false})
      .where("tasks.due_date < ?", Time.current)
      .group("pets.id"),
      items: 5
    )
    @column_name = "Overdue Tasks"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("tasks-frame", partial: "organizations/staff/dashboard/tasks", locals: {column_name: @column_name})
      end
      format.html { render :tasks, locals: {column_name: @column_name} }
    end
  end

  private

  def context_authorize!
    authorize! :dashboard,
      context: {organization: Current.organization}
  end
end
