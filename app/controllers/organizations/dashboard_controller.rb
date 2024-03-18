class Organizations::DashboardController < Organizations::BaseController
  layout "dashboard"

  def index
    @user = current_user
    @organization = @user.organization
    @hide_footer = true

    authorize! :dashboard, context: {organization: @organization}
  end
end
