class Organizations::Staff::DashboardController < Organizations::BaseController
  layout "dashboard"

  def index
    @user = current_user
    @organization = Current.organization
    @hide_footer = true
    pet_ids = @organization.pets.pluck(:id)
    @not_completed_not_overdue_tasks_count = Task.where(pet_id: pet_ids).is_not_completed.not_overdue.count
    @not_completed_overdue_tasks_count = Task.where(pet_id: pet_ids).is_not_completed.overdue.count

    authorize! :dashboard, context: {organization: @organization}
  end
end
