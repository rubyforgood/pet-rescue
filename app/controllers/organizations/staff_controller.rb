class Organizations::StaffController < Organizations::BaseController
  layout "dashboard"

  before_action :organization_admin

  def index
    @staff_accounts = StaffAccount.where(organization: current_tenant)
  end
end
