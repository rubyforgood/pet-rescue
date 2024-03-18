class Organizations::AdopterFosterDashboardController < Organizations::BaseController
  layout "dashboard"
  # before_action check adopter or fosterer

  def index
    @user = current_user
    @organization = @user.organization
    @hide_footer = true
  end
end
