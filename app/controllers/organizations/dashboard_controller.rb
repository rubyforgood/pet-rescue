class Organizations::DashboardController < Organizations::BaseController
  before_action :verified_staff

  def index
  @hide_footer = true
  end
end