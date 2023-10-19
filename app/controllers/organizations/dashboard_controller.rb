class Organizations::DashboardController < Organizations::BaseController
  layout "dashboard"
  before_action :verified_staff

  def index
    @user = current_user
    @organization = @user.organization
    @hide_footer = true
  end
end
