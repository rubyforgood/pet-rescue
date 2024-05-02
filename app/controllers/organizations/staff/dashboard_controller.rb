class Organizations::Staff::DashboardController < Organizations::BaseController
  layout "dashboard"

  def index
    @user = current_user
    @organization = Current.organization
    @hide_footer = true

    authorize! :dashboard, context: {organization: @organization}
  end
end
