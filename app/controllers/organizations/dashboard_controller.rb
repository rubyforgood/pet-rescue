class Organizations::DashboardController < Organizations::BaseController
  layout "dashboard"
  before_action :verified_staff

  def index
    @hide_footer = true
  end
end
