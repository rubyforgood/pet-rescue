class Organizations::StaffController < Organizations::BaseController
  before_action :require_organization_admin
  layout "dashboard"

  def index
    @staff_accounts = StaffAccount.all
  end
end
